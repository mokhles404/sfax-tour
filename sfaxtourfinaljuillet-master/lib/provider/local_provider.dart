import 'package:flutter/material.dart';
import 'package:untitled1/l10n/L10n.dart';



class LocaleProvider extends ChangeNotifier {
  late Locale? _locale=null;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}