part of '../app_widgets.dart';

class AppFloatingActionButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  const AppFloatingActionButton({
    required this.onPressed,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () => BaseActions.onClickButton(onPressed),
        child: Icon(Icons.add),
      );
}
