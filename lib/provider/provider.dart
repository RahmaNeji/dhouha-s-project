import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier {
  bool _isDark = false;
  String _language = 'en'; // Ajoutez une propriété language et initialisez-la à la langue par défaut

  bool get isDark => _isDark;
  String get language => _language; // Ajoutez un getter pour la propriété language

  late SharedPreferences storage;

  final darkTheme = ThemeData(
     primaryColor: Colors.black,
      brightness: Brightness.dark,
      primaryColorDark: Colors.black,
  );
  final lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    primaryColorDark: Colors.white,
  );
  void changeTheme() {
    _isDark = !_isDark;
    storage.setBool("isDark", _isDark);
    notifyListeners();
  }

  void changeLanguage(String newLanguage) { // Ajoutez une méthode pour changer la langue
    _language = newLanguage;
    notifyListeners();
  }
  init() async
  {
    storage= await SharedPreferences.getInstance();
    _isDark = storage.getBool("isDark")??false;
    notifyListeners();
  }
}