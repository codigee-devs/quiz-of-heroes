part of 'app_widgets.dart';

Widget buildBaseAutoSizeText({
  required String text,
  TextStyle style = TextStyles.quizAnswers,
  TextAlign textAlign = TextAlign.center,
  double minFontSize = 6.0,
  double maxFontSize = 16.0,
  int maxLines = 2,
}) =>
    AutoSizeText(
      text,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      maxLines: maxLines,
      style: style,
      textAlign: textAlign,
    );
