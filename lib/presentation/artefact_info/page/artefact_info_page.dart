import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/injection/injection.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../domain/entities/artefacts/artefact_entity.dart';
import '../cubit/artefact_info_cubit.dart';

class ArtefactInfoPage extends BasePage {
  final ArtefactEntity artefact;

  const ArtefactInfoPage({required this.artefact});

  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<ArtefactInfoCubit>()..init(),
        child: _Body(artefact: artefact),
      );
}

class _Body extends StatelessWidget {
  final ArtefactEntity artefact;

  const _Body({required this.artefact});

  static const double _baseBarScale = 0.055;
  static const double _baseDescInfo = 0.04;
  static const double _appbarHeightRatio = 0.15;
  static const double _baseTextWidth = 0.5;

  double _getAppbarSize(BuildContext context) => MediaQuery.of(context).size.height * _appbarHeightRatio;

  @override
  Widget build(BuildContext context) => BlocListener<ArtefactInfoCubit, ArtefactInfoState>(
        listener: (context, state) => state.maybeWhen(
          onTapBackButton: () => context.navigator.pop(),
          onTapExitButton: () => context.navigator.pushAndPopUntil(
            HomePageRoute(),
            predicate: (_) => false,
          ),
          orElse: () => null,
        ),
        child: Scaffold(
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
                  artefact.description.artefactName,
                  style: TextStyles.subtitleShadowWhite
                      .copyWith(fontSize: MediaQuery.of(context).size.height * _baseBarScale),
                ),
              ),
              rightChild: AppBaseButton.baseCancelButton(
                height: _getAppbarSize(context),
                onPressed: () => didTapCancelButton(context),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: AppDimensions.xxLargeEdgeInsets48),
                    child: SvgPicture.asset(
                      artefact.asset.path,
                      fit: BoxFit.contain,
                      height: AppDimensions.artefactInfoAssetHeight,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: AppDimensions.xxLargeEdgeInsets24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: AppDimensions.baseEdgeInsets8),
                        child: Text(
                          "${context.translate(SKeys.artefact_info_action)}",
                          style: TextStyles.artefactInfoDescBold
                              .copyWith(fontSize: MediaQuery.of(context).size.height * _baseDescInfo),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * _baseTextWidth,
                        child: Text(
                          artefact.description.actionDescription,
                          style: TextStyles.artefactInfoDescThin
                              .copyWith(fontSize: MediaQuery.of(context).size.height * _baseDescInfo),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            bottom: AppDimensions.baseEdgeInsets8, top: AppDimensions.xxLargeEdgeInsets24),
                        child: Text(
                          "${context.translate(SKeys.artefact_info_description)}:",
                          style: TextStyles.artefactInfoDescBold
                              .copyWith(fontSize: MediaQuery.of(context).size.height * _baseDescInfo),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * _baseTextWidth,
                        child: Text(
                          artefact.description.artefactDescription,
                          style: TextStyles.artefactInfoDescThin
                              .copyWith(fontSize: MediaQuery.of(context).size.height * _baseDescInfo),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  void didTapBackButton(BuildContext context) => context.read<ArtefactInfoCubit>().didTapBackButton();

  void didTapCancelButton(BuildContext context) => context.read<ArtefactInfoCubit>().didTapCancelButton();
}
