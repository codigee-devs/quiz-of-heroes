part of '../app_widgets.dart';

class AppElevatedButton extends StatelessWidget {
  final Function onPressed;
  final ButtonStyle style;
  final String text;
  final TextStyle textStyle;

  const AppElevatedButton({
    required this.onPressed,
    required this.style,
    required this.text,
    required this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () => BaseActions.onClickButton(onPressed),
        style: style,
        child: Text(
          text,
          style: textStyle,
        ),
      );
}
