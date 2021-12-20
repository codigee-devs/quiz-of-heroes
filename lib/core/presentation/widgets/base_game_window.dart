part of 'app_widgets.dart';

class BaseGameWindow extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsets margin;
  final Widget? appBar;
  final Widget child;
  const BaseGameWindow({
    required this.child,
    this.margin = EdgeInsets.zero,
    this.appBar,
    this.height = double.infinity,
    this.width = double.infinity,
  });
  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: AppColors.baseGameWindowsBackground,
          borderRadius: BorderRadius.circular(
            AppDimensions.baseRadius,
          ),
          border: Border.all(
            color: AppColors.quizBorder,
            width: AppDimensions.quizWidgetBorderSize,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.baseGameWindowsBackground,
            borderRadius: BorderRadius.circular(
              AppDimensions.baseRadius,
            ),
            border: Border.all(
              color: AppColors.quizInnerBorder,
              width: AppDimensions.quizWidgetBorderSize,
            ),
          ),
          child: Column(
            children: [
              appBar ?? Container(),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      );
}

class BaseGameWindowsAppBar extends StatelessWidget {
  final Color? color;
  final double? height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget child;
  final Widget? leftChild;
  final Widget? rightChild;
  const BaseGameWindowsAppBar({
    required this.child,
    this.margin,
    this.padding,
    this.leftChild,
    this.rightChild,
    this.height = AppDimensions.baseAppBaseButtonHeight,
    this.color = AppColors.background,
  });

  static const double _preferredSizeRatio = 0.15;
  static const double _preferredMarginRatio = 0.005;
  static const double _preferredPaddingRatio = 0.01;

  double _getPreferredSize(BuildContext context) => MediaQuery.of(context).size.height * _preferredSizeRatio;
  EdgeInsets _getPreferredMargin(BuildContext context) =>
      EdgeInsets.all(MediaQuery.of(context).size.height * _preferredMarginRatio);
  EdgeInsets _getPreferredPadding(BuildContext context) =>
      EdgeInsets.all(MediaQuery.of(context).size.height * _preferredPaddingRatio);
  @override
  Widget build(BuildContext context) => Container(
        height: height ?? _getPreferredSize(context),
        margin: margin ?? _getPreferredMargin(context),
        padding: padding ?? _getPreferredPadding(context),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppDimensions.baseSmallRadius),
        ),
        child: Row(
          children: [
            leftChild ?? Container(width: height),
            Expanded(child: child),
            rightChild ?? Container(width: height),
          ],
        ),
      );
}
