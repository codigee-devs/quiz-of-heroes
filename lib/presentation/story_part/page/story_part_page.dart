import 'package:flutter/material.dart';

import '../../../core/base_features/base/page/base_page.dart';
import '../../../core/language/localization.dart';
import '../../../core/presentation/styles/styles.dart';
import '../../../core/presentation/values/values.dart';
import '../../../core/presentation/widgets/app_widgets.dart';
import '../../../core/presentation/widgets/buttons/app_base_button.dart';
import '../../../domain/entities/history/story_description_entity.dart';

class StoryPartPage extends BasePage {
  final Function onConfirmButtonCallback;
  final StoryDescriptionEntity storyText;
  const StoryPartPage({required this.onConfirmButtonCallback, required this.storyText});

  @override
  Widget buildChildWidget(BuildContext context) => _Body(
        onConfirmButtonCallback: onConfirmButtonCallback,
        storyText: storyText,
      );
}

class _Body extends StatefulWidget {
  final Function onConfirmButtonCallback;
  final StoryDescriptionEntity storyText;

  const _Body({
    required this.onConfirmButtonCallback,
    required this.storyText,
  });

  @override
  __BodyState createState() => __BodyState(onConfirmButtonCallback, storyText);
}

class __BodyState extends State<_Body> {
  final Function onConfirmButtonCallback;
  final StoryDescriptionEntity storyText;

  __BodyState(this.onConfirmButtonCallback, this.storyText);

  _ButtonType _buttonType = _ButtonType.skipButton;
  late ScrollController _controller;

  static const double _buttonHeightRatio = 0.1;
  static const double _buttonsInsets = 5.0;
  static const double _emptySpaceBehindButton = AppDimensions.baseAppBaseButtonHeight * 1.5;
  static const double _fontSizeLargeScreen = 25.0;
  static const double _fontSizeSmallScreen = 14.0;
  static const double _skipButtonPosition = 0.0;
  static const double _skipButtonShadowBlurValue = 10.0;
  static const double _skipButtonShadowSpreadValue = 5.0;
  static const double _textPaddingRatio = 0.05;
  static const Offset _skipButtonShadowOffset = Offset(0, -15.0);

  double _getTextHorizontalMargin(BuildContext context) => MediaQuery.of(context).size.width * _textPaddingRatio;
  double _getTextVerticalPadding(BuildContext context) => _getTextHorizontalMargin(context) / 2;

  bool get _isSkipButton => _buttonType == _ButtonType.skipButton;

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_buttonListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_buttonListener);
    _controller.dispose();
    super.dispose();
  }

  void _changeButtonType(_ButtonType value) => value != _buttonType ? setState(() => _buttonType = value) : null;

  void _buttonListener() {
    if ((_controller.offset <= _controller.position.maxScrollExtent) ||
        (_controller.position.atEdge && _controller.position.pixels != 0)) {
      _changeButtonType(_ButtonType.continueButton);
    } else {
      _changeButtonType(_ButtonType.skipButton);
    }
  }

  void _scrollJumpToEnd() => _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: AppDurations.storyPartScrollAnimationDuration,
        curve: Curves.easeOut,
      );

  double _getIntroTextSize(BuildContext context) =>
      MediaQuery.of(context).size.height > 300.0 ? _fontSizeLargeScreen : _fontSizeSmallScreen;

  String _getTextByButtonType() =>
      _isSkipButton ? '${context.translate(SKeys.intro_skip)}' : '${context.translate(SKeys.intro_continue)}';

  @override
  Widget build(BuildContext context) => AppScaffold(
        body: BaseGameWindow(
          child: Stack(
            children: [
              _buildStory(storyText),
              _buildButton(),
            ],
          ),
        ),
      );

  Widget _buildHeadline(StoryDescriptionEntity storyText) {
    if (storyText.id == 0) {
      return Text(
        "Intro",
        style: TextStyles.introHeadline,
      );
    } else {
      return Text(
        "${context.translate(SKeys.intro_headline)} ${storyText.id}",
        style: TextStyles.introHeadline,
      );
    }
  }

  Widget _buildStory(StoryDescriptionEntity storyText) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        controller: _controller,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: _getTextHorizontalMargin(context),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  vertical: _getTextVerticalPadding(context),
                ),
                child: _buildHeadline(storyText),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: _emptySpaceBehindButton,
                ),
                alignment: Alignment.center,
                child: Text(
                  storyText.description,
                  style: TextStyles.introText.copyWith(
                    fontSize: _getIntroTextSize(context),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildButton() => Positioned(
        bottom: _skipButtonPosition,
        right: _skipButtonPosition,
        left: _skipButtonPosition,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _buttonsInsets),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.baseGameWindowsBackground,
              boxShadow: _isSkipButton ? _buildButtonFadeOut() : [],
            ),
            padding: _isSkipButton ? EdgeInsets.only(top: _buttonsInsets) : EdgeInsets.zero,
            margin: EdgeInsets.symmetric(horizontal: _buttonsInsets),
            child: LayoutBuilder(
              builder: (context, ui) => AppBaseButton.introButton(
                width: ui.maxWidth,
                height: ui.maxWidth * _buttonHeightRatio,
                onPressed: () => _isSkipButton ? _scrollJumpToEnd() : onConfirmButtonCallback(),
                child: Text(
                  '${_getTextByButtonType()}',
                  style: TextStyles.baseButtonStyle,
                ),
              ),
            ),
          ),
        ),
      );

  List<BoxShadow> _buildButtonFadeOut() => [
        BoxShadow(
          color: AppColors.baseGameWindowsBackground,
          blurRadius: _skipButtonShadowBlurValue,
          spreadRadius: _skipButtonShadowSpreadValue,
          offset: _skipButtonShadowOffset,
        ),
      ];
}

enum _ButtonType { skipButton, continueButton }
