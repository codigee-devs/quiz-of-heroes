part of 'utils.dart';

///
/// Function translates [Description Dto] to [Description Entity]
/// Description Dto contains map of strings in few langauges
/// function picks one of them by [Intl] locale
///

const String _defaultLocale = 'pl';

String translateDescription(Map<String, String> description) {
  final translatedDescription = description['${Intl.defaultLocale}'];
  if (translatedDescription == null || translatedDescription.isEmpty) return description[_defaultLocale] ?? '';
  return translatedDescription;
}
