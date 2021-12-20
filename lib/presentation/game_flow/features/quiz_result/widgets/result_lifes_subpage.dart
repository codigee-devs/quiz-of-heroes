part of '../page/quiz_result_page.dart';

class _QuizResultLifesSubpage extends StatelessWidget {
  final QuizResult result;
  final String correctAnswer;
  final Function buttonCallback;
  final Function menuButtonCallback;
  final bool isDiamondActionActive;
  const _QuizResultLifesSubpage({
    required this.result,
    required this.correctAnswer,
    required this.buttonCallback,
    required this.menuButtonCallback,
    required this.isDiamondActionActive,
  });

  static const double _buttonHeightRatio = 0.1;
  static const double _buttonMarginRatio = 0.01;
  static const double _contentFirstChildRatio = 0.45;
  static const double _contentHeightRatio = 0.8;
  static const double _contentSecondChildRatio = 0.48;
  static const double _diamondFontSizeRatio = 0.70;
  static const double _fontSizeRatio = 0.3;
  static const double _gameWindowsRatio = 0.03;
  static const double _lifeAssetSizeRatio = 0.6;
  static const double _skullAssetSizeRatio = 0.8;
  static const double _topContentPaddingRatio = 0.1;
  static const double _verticalContentPaddingRatio = 0.15;

  int _getSizeOfCorrectAnswer(double height, int lenWord) =>
      (height * _contentHeightRatio * (_fontSizeRatio - ((lenWord / 100) * 0.05))).toInt();

  bool get _isResultCorrect => result == QuizResult.correct;
  EdgeInsets _getButtonMargin(BuildContext context) => EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * _buttonMarginRatio,
      vertical: MediaQuery.of(context).size.height * _buttonMarginRatio);
  EdgeInsets _getGameWindowMargin(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * _gameWindowsRatio);

  EdgeInsets _getContentVerticalPadding(BoxConstraints ui) => !isDiamondActionActive
      ? EdgeInsets.symmetric(vertical: ui.maxHeight * _verticalContentPaddingRatio)
      : EdgeInsets.only(
          bottom: ui.maxHeight * _topContentPaddingRatio,
          top: ui.maxHeight * _topContentPaddingRatio,
        );

  @override
  Widget build(BuildContext context) => BaseGameWindow(
        margin: _getGameWindowMargin(context),
        appBar: _buildAppbar(),
        child: Column(
          children: [
            _buildContent(),
            _buildButton(context),
          ],
        ),
      );

  Widget _buildAppbar() => ResultGameWindowAppbar(
        result: result,
        menuButtonCallback: menuButtonCallback,
      );

  Widget _buildContent() => Expanded(
        child: LayoutBuilder(
          builder: (context, ui) => Padding(
            padding: _getContentVerticalPadding(ui),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildResult((ui.maxHeight - _getContentVerticalPadding(ui).top) * _contentFirstChildRatio, context),
                _buildCorrectAnswerText(
                    (ui.maxHeight - _getContentVerticalPadding(ui).bottom) * _contentSecondChildRatio, context),
              ],
            ),
          ),
        ),
      );

  Widget _buildResult(double height, BuildContext context) => (isDiamondActionActive && !_isResultCorrect)
      ? _buildDiamond(size: height, context: context)
      : _buildAssetImage(height);

  Widget _buildDiamond({required double size, required BuildContext context}) => Container(
        height: size,
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(
                AppImages.svgAppDiamondLarge,
                fit: BoxFit.fitHeight,
                width: double.infinity,
              ),
            ),
            Text(
              '${context.translate(SKeys.quiz_result_not_lose_life)}',
              style: TextStyles.resultNormal.copyWith(
                fontSize: size * _fontSizeRatio * _diamondFontSizeRatio,
              ),
            ),
          ],
        ),
      );

  Widget _buildAssetImage(double height) => SvgPicture.asset(
        _isResultCorrect ? AppImages.svgAppHeart : AppImages.svgQuizResultSkull,
        fit: BoxFit.fitHeight,
        height: height * (_isResultCorrect ? _lifeAssetSizeRatio : _skullAssetSizeRatio),
      );

  Widget _buildCorrectAnswerText(double height, BuildContext context) => Container(
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
            buildBaseAutoSizeText(
              text: '$correctAnswer',
              style: TextStyles.resultNormal,
              maxFontSize: _getSizeOfCorrectAnswer(height, correctAnswer.length).toDouble(),
              minFontSize: FontSizes.smallText,
              maxLines: 3,
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
}
