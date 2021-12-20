import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/injection/injection.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../domain/entities/artefacts/artefact_entity.dart';
import '../cubit/artefacts_list_cubit.dart';
import '../widget/artefacts_display.dart';

class ArtefactsListPage extends BasePage {
  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<ArtefactsListCubit>()..init(),
        child: _Body(),
      );
}

class _Body extends StatelessWidget {
  const _Body();
  static const double _appbarHeightRatio = 0.15;

  static const double _baseBarScale = 0.055;
  double _getAppbarSize(BuildContext context) => MediaQuery.of(context).size.height * _appbarHeightRatio;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BaseGameWindow(
          appBar: BaseGameWindowsAppBar(
            padding: EdgeInsets.zero,
            height: _getAppbarSize(context),
            color: AppColors.barAppBack,
            leftChild: AppBaseButton.baseBackButton(
              onPressed: () => didTapBackButton(context),
              height: _getAppbarSize(context),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDimensions.largeEdgeInsets12),
              child: Text(
                '${context.translate(SKeys.home_presentation_help)}',
                style: TextStyles.subtitleShadowWhite.copyWith(
                  fontSize: MediaQuery.of(context).size.height * _baseBarScale,
                ),
              ),
            ),
            rightChild: AppBaseButton.baseCancelButton(
              onPressed: () => didTapCancelButton(context),
              height: _getAppbarSize(context),
            ),
          ),
          child: BlocConsumer<ArtefactsListCubit, ArtefactsListState>(
            listener: (context, state) => state.maybeWhen(
              chooseArtefact: (artefact) => context.navigator.push(ArtefactInfoPageRoute(artefact: artefact)),
              onTapBackButton: () => context.navigator.pop(),
              onTapExitButton: () => context.navigator.pushAndPopUntil(HomePageRoute(), predicate: (_) => false),
              orElse: () => Container(),
            ),
            buildWhen: (prevState, currState) => currState is ArtefactsListStateLoaded,
            builder: (context, state) => state.maybeWhen(
              getArtefacts: (listArtefacts) => ArtefactsDisplay(
                artefacts: listArtefacts,
                onClick: didTapSelectArtefact,
              ),
              orElse: () => Container(),
            ),
          ),
        ),
      );

  void didTapBackButton(BuildContext context) => context.read<ArtefactsListCubit>().didTapBackButton();

  void didTapCancelButton(BuildContext context) => context.read<ArtefactsListCubit>().didTapCancelButton();

  void didTapSelectArtefact(BuildContext context, ArtefactEntity artefact) =>
      context.read<ArtefactsListCubit>().didTapSelectArtefact(artefact);
}
