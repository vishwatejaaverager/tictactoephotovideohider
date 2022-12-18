import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  static late SharedPreferences preferences;
  static const _lock = 'lock';
  static const _isReallySaved = 'really_saved';
  static const _val1 = 'value-one';
  static const _val2 = 'value-two';
  static const _val3 = 'value-three';
  static const _val4 = 'value-four';
  static const _val5 = 'value-five';
  static const _val6 = 'value-six';
  static const _val7 = 'value-seven';
  static const _val8 = 'value-eight';
  static const _torun = 'to-run';
  static const _run = 'run';

  static Future init() async {
    return preferences = await SharedPreferences.getInstance();
  }

  static Future setReallySaved(bool a) async {
    await preferences.setBool(_isReallySaved, a);
    log("it is kept");
  }

  static Future setLock(String s) async {
    await preferences.setString(_lock, s);
    log("${s}kept");
  }

  static Future setSwitchOne(bool val) async {
    await preferences.setBool(_val1, val);
  }

  static Future setSwitchTwo(bool val) async {
    await preferences.setBool(_val2, val);
  }

  static Future setSwitchThree(bool val) async {
    await preferences.setBool(_val3, val);
  }

  static Future setSwitch4(bool val) async {
    await preferences.setBool(_val4, val);
  }

  static Future setSwitch5(bool val) async {
    await preferences.setBool(_val5, val);
  }

  static Future setSwitch6(bool val) async {
    await preferences.setBool(_val6, val);
  }

  static Future setSwitch7(bool val) async {
    await preferences.setBool(_val7, val);
  }

  static Future setSwitch8(bool val) async {
    await preferences.setBool(_val8, val);
  }

  static Future setToRun(bool val) async {
    await preferences.setBool(_torun, val);
  }

  static Future setRun(bool val) async {
    await preferences.setBool(_run, val);
    log("changed set run ");
  }

  String? getLock() => preferences.getString(_lock);
  bool? getVal1() => preferences.getBool(_val1);
  bool? getVal2() => preferences.getBool(_val2);
  bool? getVal3() => preferences.getBool(_val3);
  bool? getVal4() => preferences.getBool(_val4);
  bool? getVal5() => preferences.getBool(_val5);
  bool? getVal6() => preferences.getBool(_val6);
  bool? getVal7() => preferences.getBool(_val7);
  bool? getVal8() => preferences.getBool(_val8);
  bool? getToRun() => preferences.getBool(_torun);
  bool? getRun() => preferences.getBool(_run);
  bool getIsReallySaved() => preferences.getBool(_isReallySaved) ?? true;
}
