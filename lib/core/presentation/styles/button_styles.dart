part of 'styles.dart';

abstract class ButtonStyles {
  static const double _overlayOpacity = 0.2;

  static ButtonStyle get roundedButton => ButtonStyle(
        enableFeedback: true,
        elevation: MaterialStateProperty.all<double>(
            AppDimensions.baseButtonElevation),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppDimensions.baseButtonCornerRadius)),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.azure),
        overlayColor: MaterialStateProperty.all<Color>(
            AppColors.black.withOpacity(_overlayOpacity)),
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.white),
      );
}
