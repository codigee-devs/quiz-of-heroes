import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/app/router.dart';
import '../../../core/presentation/values/values.dart';
import '../cubit/splashscreen_cubit.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen();

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: BlocProvider(
          create: (context) => SplashscreenCubit()..initServices(),
          child: _Body(),
        ),
      );
}

class _Body extends HookWidget {
  static const _innerShadowStops = [0.0, 0.7];
  static const _indicatorColor = AlwaysStoppedAnimation<Color>(AppColors.splashIndicatorColor);
  static const _indicatorHeightRatio = 0.05;
  static const _contentVerticalPaddingRatio = 0.075;
  static const _contentHorizontalPaddingRatio = 0.05;
  static const _codigeeLogoWidthRatio = 0.20;

  Future<void> _updateLoading(BuildContext context,
      {required AnimationController controller, required double value}) async {
    if (value < 0.75) {
      controller.animateTo(value);
    } else {
      controller.animateTo(1.0).whenComplete(() => _onCompletePushHome(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: AppDurations.splashscreenLoadingDuration, initialValue: 0.0);
    return BlocListener<SplashscreenCubit, SplashscreenState>(
      listener: (context, state) => state.maybeWhen(
        loading: (value) => _updateLoading(context, controller: controller, value: value),
        orElse: () => null,
      ),
      child: Column(
        children: [
          _buildContent(context),
          _buildTimeIndicator(context, controller),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) => Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * _contentVerticalPaddingRatio,
            horizontal: MediaQuery.of(context).size.width * _contentHorizontalPaddingRatio,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.orangePeel, AppColors.artyClickOrange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * _codigeeLogoWidthRatio,
              ),
              Expanded(
                child: Image.asset(AppImages.pngHomePageLogoOfGame),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * _codigeeLogoWidthRatio,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset(
                    AppImages.svgSplashCodigee,
                    width: MediaQuery.of(context).size.width * _codigeeLogoWidthRatio,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildTimeIndicator(BuildContext context, AnimationController controller) => Container(
        height: MediaQuery.of(context).size.height * _indicatorHeightRatio,
        color: AppColors.quizTimeIndicatorBackground,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.quizTimeIndicatorInnerShadow, Colors.transparent],
                  stops: _innerShadowStops,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * _indicatorHeightRatio,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, _) => LinearProgressIndicator(
                  value: controller.value,
                  valueColor: _indicatorColor,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      );

  Future<void> _onCompletePushHome(BuildContext context) =>
      context.navigator.pushAndPopUntil(HomePageRoute(), predicate: (_) => false);
}
