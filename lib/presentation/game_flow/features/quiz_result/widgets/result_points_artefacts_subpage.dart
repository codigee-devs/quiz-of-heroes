part of '../page/quiz_result_page.dart';

class _QuizResultPointsArtefactsSubpage extends StatelessWidget {
  final QuizResult result;
  final int points;
  final Function buttonCallback;
  final Function menuButtonCallback;
  const _QuizResultPointsArtefactsSubpage({
    required this.result,
    required this.points,
    required this.buttonCallback,
    required this.menuButtonCallback,
  });

  static const double _buttonMarginRatio = 0.01;
  static const double _gameWindowsRatio = 0.03;
  static const double _contentVerticalPaddingRatio = 0.09;
  static const double _fontSizeRatio = 0.2;
  static const double _fontSizeLargeRatio = _fontSizeRatio + 0.1;
  static const double _pointsAssetSizeRatio = 0.25;
  static const double _contentChildRatio = 0.5;
  static const double _buttonHeightRatio = 0.1;

  EdgeInsets _getButtonMargin(BuildContext context) => EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * _buttonMarginRatio,
      vertical: MediaQuery.of(context).size.height * _buttonMarginRatio);
  EdgeInsets _getGameWindowMargin(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * _gameWindowsRatio);
  EdgeInsets _getContentPadding(BuildContext context) =>
      EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * _contentVerticalPaddingRatio);

  @override
  Widget build(BuildContext context) => BaseGameWindow(
        margin: _getGameWindowMargin(context),
        appBar: _buildAppbar(),
        child: Column(
          children: [
            _buildContent(context),
            _buildButton(context),
          ],
        ),
      );

  Widget _buildContent(BuildContext context) => Expanded(
        child: Padding(
          padding: _getContentPadding(context),
          child: LayoutBuilder(
            builder: (context, ui) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildPoints(height: ui.maxHeight, width: ui.maxWidth * _contentChildRatio, context: context),
                _buildArtefacts(height: ui.maxHeight, width: ui.maxWidth * _contentChildRatio, context: context),
              ],
            ),
          ),
        ),
      );

  Widget _buildPoints({required double height, required double width, required BuildContext context}) => Container(
        height: height,
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${context.translate(SKeys.quiz_result_points)}',
              style: TextStyles.resultBold.copyWith(
                fontSize: height * _fontSizeRatio,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.svgAppPoint,
                    height: height * _pointsAssetSizeRatio,
                  ),
                  SizedBox(width: AppDimensions.smallSpace),
                  Text(
                    '$points',
                    style: TextStyles.outlinedWhite2.copyWith(
                      fontSize: height * _fontSizeLargeRatio,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildArtefacts({required double height, required double width, required BuildContext context}) => Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Text(
              '${context.translate(SKeys.quiz_result_new_artefacts)}',
              style: TextStyles.resultBold.copyWith(fontSize: height * _fontSizeRatio),
            ),
            SizedBox(height: AppDimensions.baseSpace),
            Expanded(
              child: ResultDrawnArtefact(),
            )
          ],
        ),
      );

  Widget _buildButton(BuildContext context) => Container(
        margin: _getButtonMargin(context),
        child: LayoutBuilder(
          builder: (context, ui) => AppBaseButton.introButton(
            onPressed: buttonCallback,
            width: ui.maxWidth,
            height: ui.maxWidth * _buttonHeightRatio,
            child: BlocBuilder<QuizResultCubit, QuizResultState>(
              buildWhen: (p, c) => c is UpdateUserInstance,
              builder: (context, state) => state.maybeWhen(
                userInstance: (instance) =>
                    _buildButtonText('${context.translate(SKeys.quiz_result_go_to_level)} ${instance.level + 1}'),
                orElse: () => _buildButtonText('${context.translate(SKeys.quiz_result_go_to_level)}'),
              ),
            ),
          ),
        ),
      );

  Widget _buildButtonText(String text) => Text(
        text,
        style: TextStyles.baseButtonStyle,
      );

  Widget _buildAppbar() => ResultGameWindowAppbar(
        result: result,
        menuButtonCallback: menuButtonCallback,
      );
}
