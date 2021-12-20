import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app/router.dart';
import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/injection/injection.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../cubit/home_cubit.dart';

class HomePage extends BasePage {
  @override
  final double horizontalPadding = 0;

  @override
  Widget buildChildWidget(BuildContext context) => BlocProvider(
        create: (_) => getIt<HomeCubit>()..init(),
        child: _Body(displaySnackBar),
      );
}

class _Body extends StatelessWidget {
  final void Function(BuildContext, String) displaySnackBar;

  const _Body(this.displaySnackBar);
  static const int _smallFlexFit = 2;
  static const int _normalFlexFit = 3;

  void _routeByButtonType(BuildContext context, HomeButtonType route) {
    switch (route) {
      case HomeButtonType.newGame:
        _didTapStartGame(context);
        break;
      case HomeButtonType.continueGame:
        context.navigator.pushAndPopUntil(
          GameFlowPageRoute(),
          predicate: (_) => false,
        );
        break;
      case HomeButtonType.help:
        context.navigator.push(ArtefactsListPageRoute());
        break;
      case HomeButtonType.logo:
        context.navigator.push(CreditsPageRoute());

        break;
      case HomeButtonType.load:
        context.navigator.push(LoadGamePageRoute());

        break;
      case HomeButtonType.rank:
        context.navigator.push(
          RankingPageRoute(
            onTapBackArrow: () => context.navigator.pop(),
          ),
        );

        break;
      case HomeButtonType.story:
        context.navigator.push(StoryListPageRoute());
        break;

      case HomeButtonType.settings:
        {
          context.navigator.push(SettingGamePageRoute());
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        body: Stack(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(
                flex: _smallFlexFit,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: AppDimensions.smallEdgeInsets4),
                    child: Image.asset(
                      AppImages.pngHomePageLogoOfGame,
                      width: AppDimensions.homeLogoSize,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: _normalFlexFit,
                child: BlocConsumer<HomeCubit, HomeState>(
                  listener: (context, state) => state.maybeWhen(
                    changePage: (button) => _routeByButtonType(context, button),
                    savedInstance: () =>
                        displaySnackBar(context, '${context.translate(SKeys.home_presentation_confirm_saving)}'),
                    startGame: (story) => context.navigator.push(
                      StoryPartPageRoute(
                        storyText: story,
                        onConfirmButtonCallback: () => context.navigator.push(ChoosingHeroPageRoute()),
                      ),
                    ),
                    orElse: () => null,
                  ),
                  buildWhen: (prevState, currState) => currState is HomeStateGameWasSaved,
                  builder: (context, state) => state.maybeWhen(
                    gameWasSaved: () => _columnWithButtons(context, true),
                    orElse: () => _columnWithButtons(context, false),
                  ),
                ),
              ),
              Flexible(
                flex: _smallFlexFit,
                child: Container(),
              ),
            ]),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                margin: const EdgeInsets.only(left: AppDimensions.basePageVerticalInsets),
                width: AppDimensions.baseAppSmallButtonSize,
                height: AppDimensions.baseAppSmallButtonSize,
                child: AppBaseButton.homeLogoOfCompanyButton(
                  onPressed: () => _didTapButton(context, type: HomeButtonType.logo),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(right: AppDimensions.basePageVerticalInsets),
                width: AppDimensions.baseAppSmallButtonSize,
                height: AppDimensions.baseAppSmallButtonSize,
                child: AppBaseButton.homeSettingButton(
                  onPressed: () => _didTapButton(context, type: HomeButtonType.settings),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _columnWithButtons(BuildContext context, bool wasSaved) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          _buildBigButtonByGameWasSaved(context, wasSaved),
          _buildSmallNewGameButton(context, wasSaved),
          _buildRowTinyButton(context, wasSaved),
          AppBaseButton.homeSmallButton(
            onPressed: () => _didTapButton(context, type: HomeButtonType.help),
            child: Text(
              context.translate(SKeys.home_presentation_help),
              style: TextStyles.homeButtonStyle,
            ),
          ),
          AppBaseButton.homeSmallButton(
            onPressed: () => _didTapButton(context, type: HomeButtonType.story),
            child: Text(
              context.translate(SKeys.home_presentation_story),
              style: TextStyles.homeButtonStyle,
            ),
          ),
          AppBaseButton.homeSmallButton(
            onPressed: () => _didTapButton(context, type: HomeButtonType.rank),
            child: Text(
              context.translate(SKeys.home_presentation_ranks),
              style: TextStyles.homeButtonStyle,
            ),
          ),
          Spacer(),
        ],
      );

  Widget _buildBigButtonByGameWasSaved(BuildContext context, bool wasSaved) => wasSaved
      ? Container(
          child: AppBaseButton.homeBigGreenButton(
            onPressed: () => _didTapButton(context, type: HomeButtonType.continueGame),
            child: Text(
              context.translate(SKeys.home_presentation_continue),
              style: TextStyles.homeGreenButton,
            ),
          ),
        )
      : Container(
          margin: const EdgeInsets.only(bottom: AppDimensions.smallEdgeInsets4),
          child: AppBaseButton.homeBigButton(
            onPressed: () => _didTapButton(context, type: HomeButtonType.newGame),
            child: Text(
              context.translate(SKeys.home_presentation_newGame),
              style: TextStyles.homeButtonStyle,
            ),
          ),
        );

  Widget _buildSmallNewGameButton(BuildContext context, bool wasSaved) {
    if (wasSaved) {
      return AppBaseButton.homeSmallButton(
        onPressed: () => _didTapButton(context, type: HomeButtonType.newGame),
        child: Text(
          context.translate(SKeys.home_presentation_newGame),
          style: TextStyles.homeButtonStyle,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildRowTinyButton(BuildContext context, bool wasSaved) {
    if (wasSaved) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: AppBaseButton.homeTinyButton(
              onPressed: () => _didTapSaveButton(context),
              child: Text(
                context.translate(SKeys.home_presentation_save),
                style: TextStyles.homeButtonStyle,
              ),
            ),
          ),
          Container(
            child: AppBaseButton.homeTinyButton(
              onPressed: () => _didTapButton(context, type: HomeButtonType.load),
              child: Text(
                context.translate(SKeys.home_presentation_load),
                style: TextStyles.homeButtonStyle,
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  void _didTapButton(BuildContext context, {required HomeButtonType type}) =>
      context.read<HomeCubit>().didTapButton(type);

  void _didTapSaveButton(BuildContext context) => context.read<HomeCubit>().didTapSaveButton();

  void _didTapStartGame(BuildContext context) => context.read<HomeCubit>().didTapStartButton();
}

enum HomeButtonType {
  newGame,
  continueGame,
  save,
  load,
  story,
  help,
  rank,
  logo,
  settings,
}
