import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/app/router.dart';
import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/injection/injection.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../core/presentation/widgets/asset_builder_widget.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../domain/entities/game_flow/user_instance_entity.dart';
import '../cubit/ranking_cubit.dart';

class RankingPage extends BasePage {
  final VoidCallback onTapBackArrow;
  const RankingPage({required this.onTapBackArrow});

  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<RankingCubit>()..init(),
        child: _Body(
          onTapBackArrow: onTapBackArrow,
        ),
      );
}

class _Body extends StatelessWidget {
  final VoidCallback onTapBackArrow;
  const _Body({required this.onTapBackArrow});

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
              onPressed: () => _didTapBackButton(context),
              height: _getAppbarSize(context),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDimensions.largeEdgeInsets12),
              child: Text(
                context.translate(SKeys.ranking_title),
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
          child: Column(
            children: [
              BlocConsumer<RankingCubit, RankingState>(
                listener: (context, state) => state.maybeWhen(
                  backToPreviousPageState: onTapBackArrow,
                  exitToMenuState: () => context.navigator.pushAndPopUntil(
                    HomePageRoute(),
                    predicate: (_) => false,
                  ),
                  orElse: () => null,
                ),
                buildWhen: (prevState, currState) =>
                    currState.maybeWhen(showRankingList: (state) => true, orElse: () => false),
                builder: (context, state) => state.maybeWhen(
                  showRankingList: _buildList,
                  orElse: () => Container(),
                ),
              ),
              BlocBuilder<RankingCubit, RankingState>(
                  buildWhen: (prevState, currState) =>
                      currState.maybeWhen(showCurrentScore: (state) => true, orElse: () => false),
                  builder: (context, state) => state.maybeWhen(
                        showCurrentScore: (instanceCurrent) => Container(
                          height: AppDimensions.rankingUserRowHeight,
                          child: _buildCurrentInstance(instanceCurrent),
                        ),
                        orElse: () => Container(),
                      )),
            ],
          ),
        ),
      );

  Widget _buildList(List<UserInstanceEntity> instances) => Expanded(
        child: Container(
          margin: EdgeInsets.only(
            left: AppDimensions.rankingListContainerMarginHorizontal,
          ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: instances.length,
            itemBuilder: (context, index) => _BuildRow(
              instance: instances[index],
              index: index,
            ),
          ),
        ),
      );

  void _didTapBackButton(BuildContext context) => context.read<RankingCubit>().didTapBackButton();

  void _didTapCancelButton(BuildContext context) => context.read<RankingCubit>().didTapCancelButton();
}

class _BuildRow extends StatelessWidget {
  final int index;
  final UserInstanceEntity instance;
  const _BuildRow({required this.instance, required this.index});

  static const int _firstChildMarginRatio = 10;

  int _firstChildMargin(int index) => (index == 0 ? _firstChildMarginRatio : 1);

  @override
  Widget build(BuildContext context) => Container(
        height: AppDimensions.rankingRowHeight,
        margin: EdgeInsets.only(
          top: AppDimensions.rankingListMarginVertical * _firstChildMargin(index),
          bottom: AppDimensions.rankingListMarginVertical,
          left: AppDimensions.rankingListMarginHorizontal,
          right: 0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text(
                '${index + 1}.    ${instance.name}',
                style: TextStyles.rankingText,
              ),
            ),
            Expanded(
              flex: 1,
              child: AssetBuilderWidget(
                asset: instance.hero.asset,
                height: MediaQuery.of(context).size.height * AppDimensions.rankingHeroAssetRatio,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Lvl. ${instance.level}',
                style: TextStyles.rankingText,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${instance.points}',
                textAlign: TextAlign.right,
                style: TextStyles.rankingText,
              ),
            ),
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                AppImages.svgAppPoint,
                fit: BoxFit.fitHeight,
                height: MediaQuery.of(context).size.height * AppDimensions.rankingStarAssetRatio,
              ),
            )
          ],
        ),
      );
}

Widget _buildCurrentInstance(UserInstanceEntity instanceCurrent) => Container(
      margin: EdgeInsets.only(
        left: AppDimensions.rankingListContainerMarginVertical,
        right: AppDimensions.rankingListContainerMarginVertical,
        bottom: AppDimensions.rankingListContainerMarginVertical,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppDimensions.rankingListUserScoreContainerBorderRadius,
          ),
          color: AppColors.quizBackground,
          boxShadow: [
            BoxShadow(
              color: AppColors.quizBorder,
              spreadRadius: AppDimensions.rankingListUserScoreContainerBorderRadius,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 5,
              child: Text(
                '${instanceCurrent.name}',
                style: TextStyles.rankingText,
              ),
            ),
            Expanded(
              child: AssetBuilderWidget(
                asset: instanceCurrent.hero.asset,
                fit: BoxFit.fitHeight,
                height: AppDimensions.rankingListUserAssetSize,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                'Lvl. ${instanceCurrent.level}',
                style: TextStyles.rankingText,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${instanceCurrent.points}',
                textAlign: TextAlign.right,
                style: TextStyles.rankingText,
              ),
            ),
            Expanded(
              child: SvgPicture.asset(
                AppImages.svgAppPoint,
                fit: BoxFit.fitHeight,
                height: AppDimensions.rankingStarAssetUserScoreSize,
              ),
            )
          ],
        ),
      ),
    );
