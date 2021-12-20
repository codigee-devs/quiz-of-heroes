part of '../page/quiz_page.dart';

class BombAnimationWidget extends HookWidget {
  final VoidCallback onAnimationCompleteCallback;

  const BombAnimationWidget({required this.onAnimationCompleteCallback});

  static const double _beginBackgroundOpacityValue = 0.0;
  static const double _endBackgroundOpacityValue = 1.0;
  static const double _assetHeightWidthRatio = 1.63;
  static const double _beginAssetHeight = 0.0;
  static const double _endAssetHeight = 400.0;

  Rect _generateBeginBombPosition(BuildContext context) => Rect.fromLTWH(
        (MediaQuery.of(context).size.width * 0.5) - ((_beginAssetHeight * 0.5) * _assetHeightWidthRatio),
        MediaQuery.of(context).size.height,
        _beginAssetHeight * _assetHeightWidthRatio,
        _beginAssetHeight,
      );

  Rect _generateEndBombPosition(BuildContext context) => Rect.fromLTWH(
        (MediaQuery.of(context).size.width * 0.5) - ((_endAssetHeight * 0.5) * _assetHeightWidthRatio),
        MediaQuery.of(context).size.height - _endAssetHeight,
        _endAssetHeight * _assetHeightWidthRatio,
        _endAssetHeight,
      );

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: AppDurations.quizBombArtefactBackgroundAnimationDuration);
    final bgAnimation = Tween<double>(begin: _beginBackgroundOpacityValue, end: _endBackgroundOpacityValue);
    final bombAnimation = RectTween(begin: _generateBeginBombPosition(context), end: _generateEndBombPosition(context));

    return BlocListener<QuizCubit, QuizState>(
      listener: (context, state) => state.maybeWhen(
        runBombAnimation: () => controller.forward().whenComplete(onAnimationCompleteCallback),
        orElse: () => null,
      ),
      child: Stack(
        children: [
          _buildBackgroundAnimation(
            animation: bgAnimation.animate(controller),
          ),
          _buildAssetAnimation(
            animation: bombAnimation.animate(controller),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundAnimation({required Animation<double> animation}) => AnimatedBuilder(
        animation: animation,
        builder: (context, _) => animation.isDismissed
            ? Container()
            : Container(
                alignment: Alignment.topCenter,
                color: AppColors.background.withOpacity(animation.value),
              ),
      );

  Widget _buildAssetAnimation({required Animation<Rect?> animation}) => AnimatedBuilder(
        animation: animation,
        builder: (context, _) => Positioned(
          left: animation.value!.left,
          top: animation.value!.top,
          child: Container(
            width: animation.value!.width,
            height: animation.value!.height,
            child: SvgPicture.asset(
              AppImages.svgQuizExplosion,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
}
