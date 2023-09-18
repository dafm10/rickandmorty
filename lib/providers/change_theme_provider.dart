import 'package:flutter/material.dart';

class ChangeTheme with ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  set isDarkTheme(bool _) {
    _isDarkTheme = _;
    notifyListeners();
  }
}
