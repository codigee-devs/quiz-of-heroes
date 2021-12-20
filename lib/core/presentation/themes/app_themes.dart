import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/styles.dart';

abstract class Themes {
  static final ThemeData lightTheme = ThemeData(
    backgroundColor: _colorScheme.background,
    brightness: Brightness.light,
    primaryColor: _colorScheme.primary,
    scaffoldBackgroundColor: _colorScheme.background,
    colorScheme: _colorScheme,
    dialogTheme: _dialogTheme,
    textTheme: _textTheme,
  );

  static final _colorScheme = const ColorScheme.light().copyWith(
    primary: Colors.blue,
    primaryVariant: Colors.blueAccent,
    secondary: Colors.red,
    secondaryVariant: Colors.red,
    background: Colors.transparent,
    surface: Colors.white,
    error: Colors.redAccent,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: Colors.lightBlue,
    onSurface: Colors.black,
    onError: Colors.white,
  );

  static final _dialogTheme = DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: _textTheme.bodyText1,
    contentTextStyle: _textTheme.bodyText1,
  );

  static const _textTheme = TextTheme(
      headline1: TextStyles.headline1,
      bodyText1: TextStyles.body1,
      button: TextStyles.button,
      headline5: TextStyles.heroName,
      headline6: TextStyles.heroStats);
}
