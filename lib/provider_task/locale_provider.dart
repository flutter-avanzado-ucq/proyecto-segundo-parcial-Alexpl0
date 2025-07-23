import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();

    final langCode = prefs.getString('langCode');

    if (langCode != null) {
      _locale = Locale(langCode);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('langCode', locale.languageCode);

    notifyListeners();
  }

  void clearLocale() async {
    _locale = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('langCode');

    notifyListeners();
  }
}
