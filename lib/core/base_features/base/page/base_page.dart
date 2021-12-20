import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../presentation/values/values.dart';

export 'package:project_skeleton/core/app/router.dart';

///
/// Base page handled 4 customizable states like: content, error, loading, initial
/// All snackbars, dialogs and common widgets for every page could included here.
///

abstract class BasePage extends StatelessWidget {
  const BasePage();

  ///
  /// Basic padding values for most sites
  /// If you need different, use override on your page
  /// [@override]
  /// [final double horizontalPadding = x;]
  ///
  ///
  ///

  final double horizontalPadding = AppDimensions.basePageHorizontalInsets;
  final double verticalPadding = AppDimensions.basePageVerticalInsets;

  @override
  Widget build(BuildContext context) => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [AppColors.orangePeel, AppColors.artyClickOrange],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        child: SafeArea(
          child: buildChildWidget(context),
        ),
      ));

  // class to be overridden on the page
  Widget buildChildWidget(BuildContext context) => Container();

  ScaffoldFeatureController displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
        content: Text(message));
    // ignore: deprecated_member_use
    return Scaffold.of(context).showSnackBar(snackBar);
  }
}
