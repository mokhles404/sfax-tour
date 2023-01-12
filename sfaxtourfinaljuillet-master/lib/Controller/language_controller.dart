import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class AppLanguage extends GetxController {
  Locale? _appLocale = Locale('en');
  final prefs = GetStorage();

  Locale get appLocal => _appLocale ?? Locale("en");

  fetchLocale() async {
    if (prefs.read('lang') == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.read('lang'));
    return Null;
  }

  void changeLanguage(Locale type) async {
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      prefs.write("lang", "ar");
      print(prefs.read("lang"));
    } else if (type == Locale("fr")) {
      _appLocale = Locale("fr");
      prefs.write("lang", "fr");
      print(prefs.read("lang"));

    } else {
      _appLocale = Locale("en");
      prefs.write("lang", "en");
      print(prefs.read("lang"));

    }
    update();
  }
}
