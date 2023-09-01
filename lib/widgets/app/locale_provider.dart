import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {

  final SharedPreferences _prefs;

  LocaleProvider(this._prefs);

  // final SharedPreferences _prefs = await newMethod();
  // final SharedPreferences _prefs;

  Locale getLocale() {
 
    final SharedPreferences prefs = _prefs;
    final String? language = prefs.getString('lang');

    final Locale? locale;
    if (language != null) {
      locale = Locale(language);
    } else {
      locale = Locale('en');
    }

    return locale;

  }

  void setLocale(Locale locale) {

    final SharedPreferences prefs = _prefs;
    prefs.setString('lang', locale.toLanguageTag());
    notifyListeners();

  }
}
