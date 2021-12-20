part of 'quiz_widget.dart';

class _BuildQuestionTextWidget extends StatefulWidget {
  final double height;
  final QuestionEntity question;
  final Function onComplete;
  const _BuildQuestionTextWidget({
    required this.height,
    required this.question,
    required this.onComplete,
  });

  @override
  _BuildQuestionTextWidgetState createState() => _BuildQuestionTextWidgetState();
}

class _BuildQuestionTextWidgetState extends State<_BuildQuestionTextWidget> with TickerProviderStateMixin {
  late Animation<int> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: AppDurations.quizQuestionAnimationDuration, vsync: this);
    _animation = StepTween(begin: 0, end: widget.question.description.length)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    SchedulerBinding.instance!.addPostFrameCallback((_) => buildAnimation());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void buildAnimation() => _controller.forward().whenComplete(() => widget.onComplete());

  @override
  Widget build(BuildContext context) => BlocBuilder<QuizCubit, QuizState>(
        buildWhen: (prevState, currState) => currState is ShowQuestionState,
        builder: (context, state) => state.maybeWhen(
          showQuestion: _buildTextWidget,
          orElse: () => Container(),
        ),
      );

  Widget _buildTextWidget() => Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.xxLargeEdgeInsets24,
          vertical: AppDimensions.xLargeEdgeInsets16,
        ),
        alignment: Alignment.center,
        height: widget.height,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) => Container(
            child: buildBaseAutoSizeText(
              text: widget.question.description.substring(0, _animation.value),
              minFontSize: 14,
              maxFontSize: 24,
              maxLines: 2,
              style: TextStyles.quizQuestion,
            ),
          ),
        ),
      );
}
