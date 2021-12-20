import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../language/localization.dart';
import '../presentation/themes/app_themes.dart';
import 'router.dart';

class CodigeeApp extends StatelessWidget {
  const CodigeeApp();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: context.router.delegate(),
        routeInformationParser: context.router.defaultRouteParser(),
        locale: DevicePreview.locale(context),
        // DevicePreview property
        builder: DevicePreview.appBuilder,
        // DevicePreview property
        title: 'Project Skeleton',
        theme: Themes.lightTheme,
        supportedLocales: S.supportedLocales,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      );
}
