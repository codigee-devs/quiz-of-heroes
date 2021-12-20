part of 'quiz_widget.dart';

enum _AnswerState {
  hidden,
  withCoin,
  halfOpacity,
  quarterOpacity,
}

class _BuildAnswersButtons extends StatefulWidget {
  final List<AnswerEntity> answers;
  final double height;
  final double width;
  final Function onComplete;
  final Function(int) updateButtonsCallback;
  const _BuildAnswersButtons({
    required this.answers,
    required this.height,
    required this.width,
    required this.onComplete,
    required this.updateButtonsCallback,
  });

  @override
  _BuildAnswersButtonsState createState() => _BuildAnswersButtonsState();
}

class _BuildAnswersButtonsState extends State<_BuildAnswersButtons> with TickerProviderStateMixin {
  late Animation _animation;
  late AnimationController _controller;
  late List<AnswerEntity> _answers;

  static const double _answerButtonHeightRatio = 0.15;
  static const double _answerButtonWidthRatio = 0.49;
  static const double _factorValueOpacity = 0.01;
  static const double _fontMaxSize = 24.0;
  static const double _fontMinSize = 1.0;
  static const double _fullyOpacityValue = 1.0;
  static const double _halfOpacityValue = 0.5;
  static const double _quarterOpacityValue = 0.25;
  static const int _animationBeginValue = 0;
  static const int _animationEndValue = 100;
  static const int _textMaxLines = 4;
  static const int _unselectedButtonsId = -1;

  final Map<_AnswerState, List<int>> _selectedAnswers = {
    _AnswerState.halfOpacity: [],
    _AnswerState.quarterOpacity: [],
    _AnswerState.withCoin: [],
    _AnswerState.hidden: [],
  };

  int _lastUpdatedButtonId = _unselectedButtonsId;
  double _answerButtonWidth = AppDimensions.quizWidgetAnswerButtonWidth;
  double _answerButtonHeight = AppDimensions.quizWidgetAnswerButtonHeight;

  bool _haveButtonState({required _AnswerState state, required int id}) => _selectedAnswers[state]!.contains(id);

  double _getOpacityById(int id) {
    final haveButtonQuarterOpacity = _haveButtonState(state: _AnswerState.quarterOpacity, id: id);
    final haveButtonHalfOpacity = _haveButtonState(state: _AnswerState.halfOpacity, id: id);
    if (haveButtonQuarterOpacity) {
      return _quarterOpacityValue;
    } else if (haveButtonHalfOpacity) {
      return _halfOpacityValue;
    } else {
      return _fullyOpacityValue;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: AppDurations.quizAnswersAnimtaionDuration, vsync: this);
    _animation = StepTween(begin: _animationBeginValue, end: _animationEndValue)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCirc));
    _answers = List.from(widget.answers);
    _answers.shuffle();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _buildAnimation() => _controller.forward().whenComplete(() => widget.onComplete());

  void _updateButtonsAndPushCallback(BuildContext context, {required int id}) {
    if (_lastUpdatedButtonId == _unselectedButtonsId || _lastUpdatedButtonId != id) {
      _lastUpdatedButtonId = id;
    } else {
      _lastUpdatedButtonId = _unselectedButtonsId;
    }
    widget.updateButtonsCallback(_lastUpdatedButtonId);
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<QuizCubit, QuizState>(
        buildWhen: (prevState, currState) => currState is ShowAnswersState,
        builder: (context, state) => state.maybeWhen(
          showAnswers: () {
            _buildAnimation();
            return _buildButtonsWidget(context);
          },
          orElse: () => Container(),
        ),
      );

  Widget _buildButtonsWidget(BuildContext context) => Container(
        height: widget.height,
        width: widget.width,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) => AnimatedOpacity(
            duration: _controller.duration!,
            opacity: _animation.value * _factorValueOpacity,
            alwaysIncludeSemantics: false,
            child: BlocBuilder<QuizCubit, QuizState>(
              buildWhen: (prevState, currState) => currState is UpdateButtonsState,
              builder: (context, state) => state.maybeWhen(
                updateButtons: (selectedButton) => _buildAnswersGrid(selectedButton: selectedButton),
                hideAnswers: (activeButton, selectedAnswers) {
                  _selectedAnswers[_AnswerState.hidden] = (_selectedAnswers[_AnswerState.hidden]! + selectedAnswers);
                  if (selectedAnswers.contains(_lastUpdatedButtonId)) {
                    _didUpdateButtons(context, id: _unselectedButtonsId);
                  }

                  return _buildAnswersGrid(selectedButton: activeButton);
                },
                lessOpacity: (activeButton, selectedAnswers) {
                  _selectedAnswers[_AnswerState.halfOpacity] = [selectedAnswers.first];
                  _selectedAnswers[_AnswerState.quarterOpacity] = [selectedAnswers.last];
                  return _buildAnswersGrid(selectedButton: activeButton);
                },
                selectCorrectAnswers: (activeButton, selectedAnswers) {
                  _selectedAnswers[_AnswerState.withCoin] = selectedAnswers;
                  return _buildAnswersGrid(selectedButton: activeButton);
                },
                orElse: () => Container(),
              ),
            ),
          ),
        ),
      );

  Widget _buildAnswerButton(BuildContext context, {required AnswerEntity answer, required isActive}) {
    final isButtonHidden = _haveButtonState(state: _AnswerState.hidden, id: answer.id);
    final isButtonWithCoin = _haveButtonState(state: _AnswerState.withCoin, id: answer.id);
    if (isButtonHidden) {
      return Container(
        height: _answerButtonHeight,
        width: _answerButtonWidth,
      );
    } else {
      return AnimatedOpacity(
        opacity: _getOpacityById(answer.id),
        duration: AppDurations.quizAnswersAnimtaionDuration,
        child: AppBaseButton.quizWidgetAnswer(
          isPressed: isActive,
          onPressed: () => _updateButtonsAndPushCallback(context, id: answer.id),
          style: AppButtonStyle.quizAnswerButton().copyWith(
            width: _answerButtonWidth,
            height: _answerButtonHeight,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.largeEdgeInsets12,
              vertical: AppDimensions.baseEdgeInsets8,
            ),
            alignment: Alignment.center,
            child: !isButtonWithCoin
                ? _buildText(answer.description)
                : _buildTextWithCoin(
                    text: answer.description,
                    assetSize: (_answerButtonHeight - 2 * AppDimensions.baseEdgeInsets8),
                  ),
          ),
        ),
      );
    }
  }

  Widget _buildTextWithCoin({required String text, required double assetSize}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            AppImages.svgAppCoinLarge,
            height: assetSize,
            width: assetSize,
          ),
          Expanded(
            child: _buildText(text),
          ),
          SizedBox(
            width: assetSize,
          ),
        ],
      );

  Widget _buildText(String text) => buildBaseAutoSizeText(
        text: '$text',
        minFontSize: _fontMinSize,
        maxFontSize: _fontMaxSize,
        maxLines: _textMaxLines,
        style: TextStyles.quizAnswers,
      );

  Widget _buildAnswersGrid({required int selectedButton}) => LayoutBuilder(
        builder: (context, ui) {
          _answerButtonWidth = ui.maxWidth * _answerButtonWidthRatio;
          _answerButtonHeight = _answerButtonWidth * _answerButtonHeightRatio;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAnswerButton(
                    context,
                    answer: _answers[0],
                    isActive: (_answers[0].id == selectedButton),
                  ),
                  _buildAnswerButton(
                    context,
                    answer: _answers[1],
                    isActive: (_answers[1].id == selectedButton),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildAnswerButton(
                    context,
                    answer: _answers[2],
                    isActive: (_answers[2].id == selectedButton),
                  ),
                  _buildAnswerButton(
                    context,
                    answer: _answers[3],
                    isActive: (_answers[3].id == selectedButton),
                  ),
                ],
              ),
            ],
          );
        },
      );

  Future<void> _didUpdateButtons(BuildContext context, {required int id}) =>
      context.read<QuizCubit>().didUpdateButtons(id: id);
}
