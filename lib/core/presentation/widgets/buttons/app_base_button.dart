import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../styles/app_button_style.dart';
import '../base_actions/base_actions.dart';

///
/// When you want to use a button, create his factory there
/// Do not call it directly
///

abstract class AppBaseButton {
  static Widget artefactsButton({required Function onPressed, required Widget child}) => _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: child,
        style: AppButtonStyle.artefactsButton(),
      );
  static Widget baseButton({required Function onPressed, required Widget child}) =>
      _AppBaseButton(onPointerUpCallback: onPressed, child: child, style: AppButtonStyle.base());
  static Widget baseBackButton({required Function onPressed, double? height}) => _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: Container(),
        style: AppButtonStyle.baseBackButton().copyWith(height: height),
      );
  static Widget baseCancelButton({required Function onPressed, double? height}) => _AppBaseButton(
      onPointerUpCallback: onPressed,
      child: Container(),
      style: AppButtonStyle.baseCancelButton().copyWith(height: height, width: height));
  static Widget characterPresentation({required Function onPressed, required Widget child}) => _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: child,
        style: AppButtonStyle.characterPresentationButton(),
      );
  static Widget creatingHeroContinueButton({required Function onPressed, required Widget child}) => _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: child,
        style: AppButtonStyle.creatingHeroContinueButton(),
      );
  static Widget homeBigButton({required Function onPressed, required Widget child}) => _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: child,
        style: AppButtonStyle.homeBigButton(),
      );
  static Widget homeBigGreenButton({required Function onPressed, required Widget child}) => _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: child,
        style: AppButtonStyle.homeBigGreenButton(),
      );
  static Widget homeLogoOfCompanyButton({required Function onPressed}) => _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: Container(),
        style: AppButtonStyle.homeLogoButton(),
      );
  static Widget homeSettingButton({required Function onPressed}) => _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: Container(),
        style: AppButtonStyle.homeSettingsButton(),
      );
  static Widget homeSmallButton({required Function onPressed, required Widget child}) => _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: child,
        style: AppButtonStyle.homeSmallButton(),
      );
  static Widget homeTinyButton({required Function onPressed, required Widget child}) => _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: child,
        style: AppButtonStyle.homeTinyButton(),
      );

  static Widget storyListButton({required Function onPressed, required Widget child, required bool isPressed}) =>
      _AppBaseButton(
        onPointerUpCallback: onPressed,
        isPressed: isPressed,
        child: child,
        style: AppButtonStyle.storyListButton(),
      );

  static Widget settingGameButton({required Function onPressed, required Widget child, required bool isPressed}) =>
      _AppBaseButton(
        child: child,
        isPressed: isPressed,
        onPointerUpCallback: onPressed,
        style: AppButtonStyle.settingGameButton(),
      );

  static Widget introButton({
    required Function onPressed,
    required Widget child,
    required double width,
    required double height,
  }) =>
      _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: child,
        style: AppButtonStyle.introButton().copyWith(width: width, height: height),
      );

  static Widget quizConfirmButton({
    required Function onPressed,
    required Widget child,
    required double width,
    required double height,
    required bool isDeactive,
  }) =>
      _AppBaseButton(
        onPointerUpCallback: onPressed,
        child: child,
        isDeactive: isDeactive,
        style: AppButtonStyle.quizConfirmButton(
          width: width,
          height: height,
        ),
      );

  static Widget quizWidgetAnswer({
    required Function onPressed,
    required bool isPressed,
    required Widget child,
    required AppButtonStyle style,
  }) =>
      _AppBaseButton(
        onPointerDownCallback: onPressed,
        child: child,
        isPressed: isPressed,
        style: style,
      );
}

///
/// Button can take an optional value [isPressed].
/// This is used to set constant button status.
/// Otherwise, the button changes state when clicked
///

class _AppBaseButton extends StatefulWidget {
  final Function? onPointerDownCallback;
  final Function? onPointerUpCallback;
  final Widget? child;
  final Widget? activeChild;
  final bool? isPressed;
  final bool isDeactive;
  final AppButtonStyle style;

  const _AppBaseButton({
    required this.child,
    required this.style,
    this.onPointerDownCallback,
    this.onPointerUpCallback,
    this.activeChild,
    this.isPressed,
    this.isDeactive = false,
  });

  @override
  _AppBaseButtonState createState() => _AppBaseButtonState();
}

class _AppBaseButtonState extends State<_AppBaseButton> {
  _ButtonState __buttonState = _ButtonState.deactive;
  bool get _isButtonImmutable => widget.isPressed != null;
  bool get _isButtonPressed => _isButtonImmutable ? widget.isPressed! : __buttonState == _ButtonState.active;

  void _updateButtonState() =>
      setState(() => __buttonState = _isButtonPressed ? _ButtonState.deactive : _ButtonState.active);

  void _onPointerUpCallback({required bool newState}) {
    widget.onPointerUpCallback != null ? BaseActions.onClickButton(widget.onPointerUpCallback!) : null;
    newState ? _updateButtonState() : null;
  }

  void _onPointerDownCallback({required bool newState}) {
    widget.onPointerDownCallback != null ? BaseActions.onClickButton(widget.onPointerDownCallback!) : null;
    newState ? _updateButtonState() : null;
  }

  ImageProvider _getBackgroundImage() {
    final activeBackgroundImage = widget.style.activeBackgroundImage ?? widget.style.backgroundImage;
    precacheImage(activeBackgroundImage, context);
    precacheImage(widget.style.backgroundImage, context);
    if (widget.isDeactive && (widget.style.deactiveBackgroundImage != null)) {
      return widget.style.deactiveBackgroundImage!;
    } else {
      return _isButtonPressed ? activeBackgroundImage : widget.style.backgroundImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeChild = widget.activeChild ?? widget.child;
    return Listener(
      onPointerDown: (_) => !widget.isDeactive ? _onPointerDownCallback(newState: !_isButtonImmutable) : null,
      onPointerUp: (_) => !widget.isDeactive ? _onPointerUpCallback(newState: !_isButtonImmutable) : null,
      child: Container(
        height: widget.style.height,
        width: widget.style.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: _getBackgroundImage(),
            fit: widget.style.boxFit,
          ),
        ),
        child: _isButtonPressed ? activeChild : widget.child,
      ),
    );
  }
}

enum _ButtonState { active, deactive }
