import 'dart:async' show Future;
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'constant.dart' show LANGUAGES;

class MyLocalizations {
  final Map<String, Map<String, String>> localizedValues;

  MyLocalizations(this.locale, this.localizedValues);

  final Locale locale;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  String getTranslationByKey(String key) =>
      localizedValues[locale.languageCode][key];
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  Map<String, Map<String, String>> localizedValues;

  MyLocalizationsDelegate(this.localizedValues);

  @override
  bool isSupported(Locale locale) => LANGUAGES.contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return SynchronousFuture<MyLocalizations>(
        MyLocalizations(locale, localizedValues));
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
