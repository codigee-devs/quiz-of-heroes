part of '../page/game_over_page.dart';

class _GameOverSubpage extends StatelessWidget {
  final Function buttonCallback;
  const _GameOverSubpage({
    required this.buttonCallback,
  });

  static const double _buttonHeightRatio = 0.1;
  static const double _buttonMarginRatio = 0.01;
  static const double _gameWindowsRatio = 0.03;
  static const double _verticalContentMarginRatio = 0.15;
  static const double _contentChildRatio = 0.6;

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
            _buildContent(),
            _buildButton(context),
          ],
        ),
      );

  BaseGameWindowsAppBar _buildAppbar(BuildContext context) => BaseGameWindowsAppBar(
        color: AppColors.black,
        child: Text(
          '${context.translate(SKeys.quiz_result_game_over_title)}',
          textAlign: TextAlign.center,
          style: TextStyles.blackAppBarTitle,
        ),
      );

  Widget _buildContent() => Expanded(
        child: LayoutBuilder(
          builder: (context, ui) => Padding(
            padding: EdgeInsets.symmetric(vertical: ui.maxHeight * _verticalContentMarginRatio),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildAssetImage((ui.maxHeight * _contentChildRatio)),
              ],
            ),
          ),
        ),
      );

  Widget _buildAssetImage(double height) => Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(
                AppImages.svgQuizGameOverSkeleton,
                fit: BoxFit.contain,
                width: double.infinity,
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
              '${context.translate(SKeys.quiz_result_game_over_button)}',
              style: TextStyles.baseButtonStyle,
            ),
          ),
        ),
      );
}
