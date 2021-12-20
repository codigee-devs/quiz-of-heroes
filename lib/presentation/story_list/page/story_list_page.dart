import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/injection/injection.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../cubit/story_list_cubit.dart';

class StoryListPage extends BasePage {
  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<StoryListCubit>()..init(),
        child: _Body(),
      );
}

class _Body extends StatelessWidget {
  static const double _appbarHeightRatio = 0.15;
  static const double _baseBarScale = 0.055;
  static const double _baseListViewScale = 0.4;

  double _getAppbarSize(BuildContext context) => MediaQuery.of(context).size.height * _appbarHeightRatio;
  double _getListViewHeight(BuildContext context) => MediaQuery.of(context).size.height * 0.5;
  double _getListViewWidth(BuildContext context) => MediaQuery.of(context).size.width * _baseListViewScale;

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
                context.translate(SKeys.setting_game_story),
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
          child: BlocConsumer<StoryListCubit, StoryListState>(
            listener: (context, state) => state.maybeWhen(
              onTapBackButton: () => context.navigator.pop(),
              displayStory: (story) => context.navigator.push(
                StoryPartPageRoute(
                  onConfirmButtonCallback: () => context.navigator.pop(),
                  storyText: story,
                ),
              ),
              onTapExitButton: () => context.navigator.pushAndPopUntil(
                HomePageRoute(),
                predicate: (_) => false,
              ),
              orElse: () => null,
            ),
            buildWhen: (prevState, currState) => currState is StoryListStateDisplayButtons,
            builder: (context, state) => state.maybeWhen(
              displayButtons: (howMuchReaveal) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _singleColumn(AppImages.svgAppWarrior, howMuchReaveal[0], context),
                  _singleColumn(AppImages.svgAppWitch, howMuchReaveal[1], context),
                ],
              ),
              orElse: () => Container(),
            ),
          )));

  Widget _singleColumn(String asset, int howManyStories, BuildContext context) => Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: AppDimensions.smallEdgeInsets4),
            child: SvgPicture.asset(
              asset,
              height: AppDimensions.artefactInfoAssetHeight,
            ),
          ),
          SizedBox(
            height: _getListViewHeight(context),
            width: _getListViewWidth(context),
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(top: AppDimensions.smallEdgeInsets4),
                child: AppBaseButton.storyListButton(
                    onPressed: (index < howManyStories) ? () => _didTapDisplayStory(context, 0, index + 1) : () => null,
                    child: Text(
                      (index < howManyStories)
                          ? "${context.translate(SKeys.intro_headline)} ${index + 1}"
                          : context.translate(SKeys.story_game_not_discovered),
                      style: TextStyles.homeButtonStyle,
                    ),
                    isPressed: index >= howManyStories),
              ),
            ),
          )
        ],
      );

  void _didTapDisplayStory(BuildContext context, int id, int number) =>
      context.read<StoryListCubit>().didTapDisplayStory(id, number);

  void _didTapBackButton(BuildContext context) => context.read<StoryListCubit>().didTapBackButton();

  void _didTapCancelButton(BuildContext context) => context.read<StoryListCubit>().didTapCancelButton();
}
