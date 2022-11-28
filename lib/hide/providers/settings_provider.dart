import 'package:flutter/cupertino.dart';

class SettingsProvider with ChangeNotifier {
  bool _isDarkmode = false;
  bool get isDarkmode => _isDarkmode;

  setDarkmode(bool v) {
    _isDarkmode = v;
    notifyListeners();
  }
}
