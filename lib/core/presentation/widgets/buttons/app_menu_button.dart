part of '../app_widgets.dart';

class AppMenuButton extends StatelessWidget {
  final Function onPressed;
  final double size;

  const AppMenuButton({
    required this.onPressed,
    required this.size,
  });

  Widget build(BuildContext context) => InkWell(
      onTap: () => BaseActions.onClickButton(onPressed),
      child: SvgPicture.asset(
        AppImages.svgAppMenu,
        height: size,
        width: size,
        color: AppColors.buttonMenu,
      ));
}
