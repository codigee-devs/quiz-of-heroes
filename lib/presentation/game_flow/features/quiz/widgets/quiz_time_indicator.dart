part of '../page/quiz_page.dart';

class QuizTimeIndicator extends StatefulWidget {
  final double height;
  final Function onCompleteCallback;
  final Function startTimerCallback;
  final AnimationController controler;

  const QuizTimeIndicator({
    required this.height,
    required this.onCompleteCallback,
    required this.startTimerCallback,
    required this.controler,
  });
  @override
  QuizTimeIndicatorState createState() => QuizTimeIndicatorState();
}

class QuizTimeIndicatorState extends State<QuizTimeIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<Color?> _color;

  static const _tweenWeight = 1.0;
  static const _innerShadowStops = [0.0, 0.7];
  static const _animationBegin = 0.0;
  static const _animationEnd = 1.0;
  static final _pausedTimerColor = AlwaysStoppedAnimation<Color>(AppColors.quizTimeIndicatorPaused);

  @override
  void initState() {
    super.initState();
    _controller = widget.controler;
    _animation = ReverseAnimation(Tween<double>(begin: _animationBegin, end: _animationEnd).animate(_controller));
    _color = _buildColorAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _runAnimation() => _controller.forward().whenComplete(() => widget.onCompleteCallback());

  Future<void> _pauseAnimation(BuildContext context, Duration duration) async {
    _controller.stop();
    await Future.delayed(duration).then((_) => widget.startTimerCallback());
  }

  Animation<Color?> _buildColorAnimation() => TweenSequence([
        TweenSequenceItem(
          tween: ColorTween(begin: AppColors.quizTimeIndicatorMaxValue, end: AppColors.quizTimeIndicatorMidValue),
          weight: _tweenWeight,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: AppColors.quizTimeIndicatorMidValue, end: AppColors.quizTimeIndicatorMinValue),
          weight: _tweenWeight,
        ),
      ]).animate(_controller);

  @override
  Widget build(BuildContext context) => Container(
        height: widget.height,
        color: AppColors.quizTimeIndicatorBackground,
        child: Stack(
          children: [
            _buildInnerShadow(),
            _buildAnimatedProgressBar(),
          ],
        ),
      );

  Widget _buildInnerShadow() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.quizTimeIndicatorInnerShadow, Colors.transparent],
            stops: _innerShadowStops,
          ),
        ),
      );

  Widget _buildAnimatedProgressBar() => BlocBuilder<QuizCubit, QuizState>(
        buildWhen: (p, c) => c is UpdateTimerState,
        builder: (context, state) => state.maybeWhen(
          initial: () => _buildProgressBar(_color),
          runTimer: () {
            _runAnimation();
            return _buildProgressBar(_color);
          },
          pauseTimer: (duration) {
            _pauseAnimation(context, duration);
            return _buildProgressBar(_pausedTimerColor);
          },
          orElse: () => Container(),
        ),
      );

  Widget _buildProgressBar(Animation<Color?> color) => Container(
        height: widget.height,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) => LinearProgressIndicator(
            value: _animation.value,
            valueColor: color,
          ),
        ),
      );
}
