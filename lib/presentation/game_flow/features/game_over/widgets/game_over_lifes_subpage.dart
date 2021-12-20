part of '../page/game_over_page.dart';

class _GameOverLifesSubpage extends StatelessWidget {
  final Function buttonCallback;
  final String correctAnswer;

  const _GameOverLifesSubpage({
    required this.buttonCallback,
    required this.correctAnswer,
  });

  static const double _assetSizeRatio = 0.8;
  static const double _buttonHeightRatio = 0.1;
  static const double _buttonMarginRatio = 0.01;
  static const double _contentFirstChildRatio = 0.45;
  static const double _contentHeightRatio = 0.8;
  static const double _contentSecondChildRatio = 0.48;
  static const double _fontSizeRatio = 0.3;
  static const double _gameWindowsRatio = 0.03;
  static const double _topContentPaddingRatio = 0.1;

  EdgeInsets _getButtonMargin(BuildContext context) => EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * _buttonMarginRatio,
      vertical: MediaQuery.of(context).size.height * _buttonMarginRatio);
  EdgeInsets _getGameWindowMargin(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * _gameWindowsRatio);

  EdgeInsets _getContentVerticalPadding(BoxConstraints ui) => EdgeInsets.only(
        bottom: ui.maxHeight * _topContentPaddingRatio,
        top: ui.maxHeight * _topContentPaddingRatio,
      );

  @override
  Widget build(BuildContext context) => BaseGameWindow(
        margin: _getGameWindowMargin(context),
        appBar: _buildAppbar(context),
        child: Column(
          children: [
            _buildContent(),
            _buildButton(context),
          ],
        ),
      );

  Widget _buildAppbar(BuildContext context) => ResultGameWindowAppbar(
        result: QuizResult.wrong,
        menuButtonCallback: () => _didTapMenuButton(context),
      );

  Widget _buildContent() => Expanded(
        child: LayoutBuilder(
          builder: (context, ui) => Padding(
            padding: _getContentVerticalPadding(ui),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAssetImage((ui.maxHeight - _getContentVerticalPadding(ui).top) * _contentFirstChildRatio),
                _buildCorrectAnswerText(
                    (ui.maxHeight - _getContentVerticalPadding(ui).bottom) * _contentSecondChildRatio, context),
              ],
            ),
          ),
        ),
      );

  Widget _buildAssetImage(double height) => SvgPicture.asset(
        AppImages.svgQuizResultSkull,
        fit: BoxFit.fitHeight,
        height: height * _assetSizeRatio,
      );

  Widget _buildCorrectAnswerText(double height, BuildContext context) => Container(
        height: height * _contentHeightRatio,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${context.translate(SKeys.quiz_result_correct_answer_is)}',
              style: TextStyles.resultBold.copyWith(
                fontSize: (height * _contentHeightRatio) * _fontSizeRatio,
              ),
            ),
            Text(
              '$correctAnswer',
              style: TextStyles.resultNormal.copyWith(
                fontSize: (height * _contentHeightRatio) * _fontSizeRatio,
              ),
            ),
          ],
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
              '${context.translate(SKeys.quiz_result_next)}',
              style: TextStyles.baseButtonStyle,
            ),
          ),
        ),
      );

  Future<void> _didTapMenuButton(BuildContext context) => context.read<GameFlowCubit>().didBackToMenu();
}
