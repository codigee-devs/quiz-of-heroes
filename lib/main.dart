import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'core/app/app.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false, // false - disable permanently | true enable permanently
      builder: (context) => const CodigeeApp(),
    ),
  );
}
