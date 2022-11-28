import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_project_first/preferences/preferences.dart';

class LockScreenProvider with ChangeNotifier {
  UserPreference preference = UserPreference();
  String _pass = '1234';
  String get pass => _pass;

  getLockPass() {
    _pass = preference.getLock() ?? '1234';
    log(_pass + " this is from db");
  }

  setPasscode(String s) {
    UserPreference.setLock(s);
    log("saved $s");
  }
}
