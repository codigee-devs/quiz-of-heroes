part of '../page/game_over_page.dart';

class _GameOverScoreSubpage extends StatelessWidget {
  final Function buttonCallback;
  final UserInstanceEntity instance;

  const _GameOverScoreSubpage({
    required this.buttonCallback,
    required this.instance,
  });

  static const double _buttonHeightRatio = 0.1;
  static const double _buttonMarginRatio = 0.01;
  static const double _gameWindowsRatio = 0.03;
  static const double _starAssetRatio = 0.15;
  static const double _heroAssetRatio = 0.8;
  static const double _fontSizeNameText = 35;
  static const double _fontSizeScoreText = 30;

  EdgeInsets _getButtonMargin(BuildContext context) => EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * _buttonMarginRatio,
      vertical: MediaQuery.of(context).size.height * _buttonMarginRatio);
  EdgeInsets _getGameWindowMargin(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * _gameWindowsRatio);

  @override
  Widget build(BuildContext context) => BaseGameWindow(
        margin: _getGameWindowMargin(context),
        appBar: _buildAppbar(context),
        child: Column(
          children: [
            _buildContent(instance),
            _buildButton(context),
          ],
        ),
      );

  BaseGameWindowsAppBar _buildAppbar(BuildContext context) => BaseGameWindowsAppBar(
        color: AppColors.black,
        child: Text(
          '${context.translate(SKeys.quiz_result_game_over_score_title)}',
          textAlign: TextAlign.center,
          style: TextStyles.blackAppBarTitle,
        ),
      );

  Widget _buildContent(UserInstanceEntity instance) => Expanded(
        child: LayoutBuilder(
          builder: (context, ui) => Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: AssetBuilderWidget(
                      asset: instance.hero.asset,
                      width: ui.maxWidth * _heroAssetRatio,
                      height: ui.maxHeight * _heroAssetRatio,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${instance.name}',
                          style: TextStyles.resultBold.copyWith(
                            fontSize: _fontSizeNameText,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Lvl. ${instance.level}      ',
                              style: TextStyles.resultBold.copyWith(
                                fontSize: _fontSizeScoreText,
                                fontWeight: FontWeight.w700,
                              )),
                          Container(
                              height: ui.maxHeight * _starAssetRatio,
                              width: ui.maxHeight * _starAssetRatio,
                              child: SvgPicture.asset(
                                AppImages.svgAppPoint,
                                fit: BoxFit.fill,
                              )),
                          Text(
                            '${instance.points}',
                            style: TextStyles.resultBold.copyWith(
                              fontSize: _fontSizeScoreText,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget _buildButton(BuildContext context) => Container(
        margin: _getButtonMargin(context),
        child: LayoutBuilder(
          builder: (context, ui) => AppBaseButton.introButton(
            width: ui.maxWidth,
            height: ui.maxWidth * _buttonHeightRatio,
            onPressed: buttonCallback,
            child: Text(
              '${context.translate(SKeys.quiz_result_game_over_score_button)}',
              style: TextStyles.baseButtonStyle,
            ),
          ),
        ),
      );
}
