import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/injection/injection.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../core/presentation/widgets/asset_builder_widget.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../domain/entities/game_flow/user_instance_entity.dart';
import '../cubit/load_game_cubit.dart';

class LoadGamePage extends BasePage {
  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<LoadGameCubit>()..init(),
        child: _Body(),
      );
}

class _Body extends StatelessWidget {
  static const double _appbarHeightRatio = 0.15;
  static const double _baseBarScale = 0.055;
  static const double _setNumberChildAspect = 3.5;

  static const int _setMaxNumberOfLines = 2;
  static const int _setNumbersOfItemsInRow = 2;

  double _getAppbarSize(BuildContext context) => MediaQuery.of(context).size.height * _appbarHeightRatio;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BaseGameWindow(
          appBar: BaseGameWindowsAppBar(
            padding: EdgeInsets.zero,
            height: _getAppbarSize(context),
            color: AppColors.barAppBack,
            leftChild: AppBaseButton.baseBackButton(
              onPressed: () => _didTapBackButton(context),
              height: _getAppbarSize(context),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDimensions.largeEdgeInsets12),
              child: Text(
                context.translate(SKeys.load_page_load_game),
                style: TextStyles.subtitleShadowWhite.copyWith(
                  fontSize: MediaQuery.of(context).size.height * _baseBarScale,
                ),
              ),
            ),
            rightChild: AppBaseButton.baseCancelButton(
              onPressed: () => _didTapCancelButton(context),
              height: _getAppbarSize(context),
            ),
          ),
          child: BlocConsumer<LoadGameCubit, LoadGameState>(
            listener: (context, state) => state.maybeWhen(
              startGame: () => context.navigator.pushAndPopUntil(
                GameFlowPageRoute(),
                predicate: (_) => false,
              ),
              onTapBackButton: () => context.navigator.pop(),
              onTapExitButton: () => context.navigator.pushAndPopUntil(
                HomePageRoute(),
                predicate: (_) => false,
              ),
              orElse: () => Container(),
            ),
            buildWhen: (prevState, currState) => currState is LoadGameStateGetSaves,
            builder: (context, state) => state.maybeWhen(
              getSaves: (saves) => _gridView(context, saves),
              orElse: () => Container(),
            ),
          ),
        ),
      );

  Widget _gridView(BuildContext context, List<UserInstanceEntity> saves) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _setNumbersOfItemsInRow,
          childAspectRatio: _setNumberChildAspect,
        ),
        itemCount: saves.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => _didTapChooseHero(context, saves[index]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AssetBuilderWidget(
                asset: saves[index].hero.asset,
                height: AppDimensions.loadHeroSize,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    saves[index].name,
                    style: TextStyles.heroName,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppImages.svgAppHeart),
                      Text('${saves[index].lifes}', style: TextStyles.heroName),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: AppDimensions.xLargeEdgeInsets16),
                        child: Text('Lvl. ${saves[index].level}', style: TextStyles.heroName),
                      ),
                      SvgPicture.asset(AppImages.svgAppPoint),
                      AutoSizeText('${saves[index].points}',
                          style: TextStyles.heroName, maxLines: _setMaxNumberOfLines),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  void _didTapChooseHero(BuildContext context, UserInstanceEntity saves) =>
      context.read<LoadGameCubit>().didTapChooseHero(saves);

  void _didTapBackButton(BuildContext context) => context.read<LoadGameCubit>().didTapBackButton();

  void _didTapCancelButton(BuildContext context) => context.read<LoadGameCubit>().didTapCancelButton();
}
