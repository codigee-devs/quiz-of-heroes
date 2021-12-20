import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sprintf/sprintf.dart';

part 'localization_keys.dart';

class S {
  // Static Properties
  static const delegate = _SDelegate();
  static const supportedLocales = [
    Locale('pl', 'PL'),
  ];
  // Public Properties
  final Locale locale;
  // Private Properties
  late Map<String, String> _localizedStrings;
  // Initialization
  S(this.locale);
  // Static Methods
  static S? of(BuildContext context) => Localizations.of<S>(context, S);
  // Public Methods
  Future<void> load() => rootBundle
      .loadString('assets/language/${locale.languageCode}.json')
      .then((value) => json.decode(value))
      .then((value) => _cast<Map<String, dynamic>>(value, fallback: {}))
      .then(_mapJsonToLocalizedStrings);
  String translate(String key) => _localizedStrings[key] ?? key;
  // Private Methods
  void _mapJsonToLocalizedStrings(Map<String, dynamic>? json) {
    _localizedStrings = (json?.map((k, v) => MapEntry(k, v.toString())) ?? {});
  }
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();
  @override
  bool isSupported(Locale locale) => S.supportedLocales.map((e) => e.languageCode).contains(locale.languageCode);
  @override
  Future<S> load(Locale locale) async {
    final value = S(locale);
    await value.load();
    return Future.value(value);
  }

  @override
  bool shouldReload(_SDelegate old) => false;
}

/// Method allows to typecast any value from dynamic.
/// Example of usage:
/// var x = something();
/// String s = cast(x, fallback: 'nothing');
T? _cast<T>(dynamic x, {T? fallback}) {
  if (x is T) return x;
  debugPrint('❌ TypeError when trying to cast $x to $T!');
  return fallback;
}

extension LocalizationExtension on BuildContext {
  String translate(String key, {dynamic arguments}) {
    final translation = S.of(this)?.translate(key) ?? key;
    return arguments == null ? translation : sprintf(translation, arguments);
  }
}
