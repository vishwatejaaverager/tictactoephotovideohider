import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:my_project_first/main.dart';
import 'package:my_project_first/preferences/preferences.dart';

class HideLocationProvider with ChangeNotifier {
  final UserPreference _preference = UserPreference();
  // ignore: prefer_final_fields
  // bool? _a = true;
  // bool? get a => _a;

  // bool? _b = true;
  // bool? get b => _b;

  // bool? _c = true;
  // bool? get c => _c;

  //List _hideList = [
  //   '0',
  //   '0',
  //   '0',
  //   '0',
  //   '0',
  //   '0',
  //   '0',
  //   '0',
  //   '0',
  // ];
  // List get hideList => _hideList;

  int _maxLimit = 0;
  int get maxLimit => _maxLimit;

  bool _hideLocation = false;
  bool get hideLocation => _hideLocation;

  bool _hideLocation1 = false;
  bool get hideLocation1 => _hideLocation1;

  bool _hideLocation2 = false;
  bool get hideLocation2 => _hideLocation2;

  bool _hideLocation3 = false;
  bool get hideLocation3 => _hideLocation3;

  bool _hideLocation4 = false;
  bool get hideLocation4 => _hideLocation4;

  bool _hideLocation5 = false;
  bool get hideLocation5 => _hideLocation5;

  bool _hideLocation6 = false;
  bool get hideLocation6 => _hideLocation6;

  bool _hideLocation7 = false;
  bool get hideLocation7 => _hideLocation7;

  // getDefaultValues() {
  //   log("called default val list");
  //   bool? a = _preference.getVal1();
  //   log("${a}vaal a");
  //   bool? b = _preference.getVal2();
  //   log("${b}vaal b");
  //   bool? c = _preference.getVal3();
  //   log("${c}vaal c");
  //   setHideLocation(a ?? true);
  //   setHideLocation1(b ?? true);
  //   setHideLocation2(c ?? true);
  //   UserPreference.setToRun(false);
  //   //UserPreference.setRun(true);
  // }

  setswitchone(bool v) {
    UserPreference.setSwitchOne(v);
    _hideLocation = v;
    log("saved");
    log("${_hideLocation}hide location 0th");
    notifyListeners();
  }

  setswitch2(bool v) {
    UserPreference.setSwitchTwo(v);
    _hideLocation1 = v;
    log("saved");
    notifyListeners();
  }

  setswitch3(bool v) {
    UserPreference.setSwitchThree(v);
    _hideLocation2 = v;
    log("saved");
    notifyListeners();
  }

  setswitch4(bool v) {
    UserPreference.setSwitch4(v);
    _hideLocation3 = v;
    log("saved");
    notifyListeners();
  }

  setSwitch5(bool v) {
    UserPreference.setSwitch5(v);
    _hideLocation4 = v;
  }

  setSwitch6(bool v) {
    UserPreference.setSwitch6(v);
    _hideLocation5 = v;
  }

  setSwitch7(bool v) {
    UserPreference.setSwitch7(v);
    _hideLocation6 = v;
  }

  setSwitch8(bool v) {
    UserPreference.setSwitch8(v);
    _hideLocation7 = v;
  }

  setBoolsofSwitches(BuildContext context) async {
    bool firstRun = await IsFirstRun.isFirstRun();
    if (firstRun) {
      log("called here first ");
      try {
        UserPreference.setSwitchOne(true);
        UserPreference.setSwitchTwo(true);
        UserPreference.setSwitchThree(true);
        UserPreference.setSwitch4(false);
        UserPreference.setSwitch5(false);
        UserPreference.setSwitch6(false);
        UserPreference.setSwitch7(false);
        UserPreference.setSwitch8(false);
        UserPreference.setToRun(true);
        UserPreference.setRun(false);
        set1(true);
        set2(true);
        set3(true);
       
       

        log("setted");
      } catch (e) {
        log(e.toString());
      }
    }
  }

  gethideList() {
    log("called hidelist ");
    bool? a = _preference.getVal1();
    log("$a val a");
    bool? b = _preference.getVal2();
    log("$b val b");
    bool? c = _preference.getVal3();
    log("$c val c");
    bool? d = _preference.getVal4();
    log("$d val d");
    bool? e = _preference.getVal5();
    log("$e val e");
    bool? f = _preference.getVal6();
    log("$f val f");
    bool? g = _preference.getVal7();
    log("$g val g");
    bool? h = _preference.getVal8();
    log("$h val h");

    set1(a!);
    set2(b!);
    set3(c!);
    set4(d!);
    set5(e!);
    set6(f!);
    set7(g!);
    set8(h!);
  }

  set1(bool a) {
    _hideLocation = a;
    if (a) {
      // _hideList[6] = '1';
      // _hideList[7] = '1';
      // _hideList[8] = '1';
    }
    notifyListeners();
  }

  set2(bool a) {
    _hideLocation1 = a;
    if (a) {
      // _hideList[3] = '2';
      // _hideList[4] = '2';
      // _hideList[5] = '2';
    }
    notifyListeners();
  }

  set3(bool a) {
    _hideLocation2 = a;
    if (a) {
      // _hideList[0] = '3';
      // _hideList[1] = '3';
      // _hideList[2] = '3';
    }
    notifyListeners();
  }

  set4(bool a) {
    _hideLocation3 = a;

    if (a) {
      // _hideList[0] = '4';
      // _hideList[3] = '4';
      // _hideList[6] = '4';
    }
    notifyListeners();
  }

  set5(bool a) {
    _hideLocation4 = a;
    if (a) {
      // _hideList[1] = '5';
      // _hideList[4] = '5';
      // _hideList[7] = '5';
    }
    notifyListeners();
  }

  set6(bool a) {
    _hideLocation5 = a;
    if (a) {
      // _hideList[2] = '6';
      // _hideList[5] = '6';
      // _hideList[8] = '6';
    }
    notifyListeners();
  }

  set7(bool a) {
    _hideLocation6 = a;
    if (a) {
      // _hideList[2] = '7';
      // _hideList[4] = '7';
      // _hideList[6] = '7';
    }
    notifyListeners();
  }

  set8(bool a) {
    _hideLocation7 = a;
    if (a) {
      // _hideList[0] = '8';
      // _hideList[4] = '8';
      // _hideList[8] = '8';
    }
    notifyListeners();
  }

  setHideLocation(bool v) {
    _hideLocation = v;
    if (_hideLocation) {
      // _hideList[6] = '1';
      // _hideList[7] = '1';
      // _hideList[8] = '1';
      setswitchone(v);
      _maxLimit++;
    } else {
      // _hideList[6] = '0';
      // _hideList[7] = '0';
      // _hideList[8] = '0';
      setswitchone(v);
      _maxLimit--;
    }
    reset();
    // log(_maxLimit.toString());
    // log(_hideLocation.toString());
    notifyListeners();
  }

  setHideLocation1(bool v) {
    _hideLocation1 = v;
    if (_hideLocation1) {
      // _hideList[3] = '2';
      // _hideList[4] = '2';
      // _hideList[5] = '2';
      setswitch2(v);
      _maxLimit++;
    } else {
      // _hideList[3] = '0';
      // _hideList[4] = '0';
      // _hideList[5] = '0';
      setswitch2(v);
      _maxLimit--;
    }
    reset();
    // log(_maxLimit.toString());
    // log(_hideLocation1.toString());
    notifyListeners();
  }

  setHideLocation2(bool v) {
    _hideLocation2 = v;
    if (_hideLocation2) {
      // _hideList[0] = '3';
      // _hideList[1] = '3';
      // _hideList[2] = '3';
      setswitch3(v);
      _maxLimit++;
    } else {
      // _hideList[0] = '0';
      // _hideList[1] = '0';
      // _hideList[2] = '0';
      setswitch3(v);
      _maxLimit--;
    }
    reset();
    // log(_maxLimit.toString());
    // log(_hideLocation2.toString());
    notifyListeners();
  }

  setHideLocation3(bool v) {
    _hideLocation3 = v;
    if (_hideLocation3) {
      // _hideList[0] = '4';
      // _hideList[3] = '4';
      // _hideList[6] = '4';
      setswitch4(v);
      _maxLimit++;
    } else {
      // _hideList[0] = '0';
      // _hideList[3] = '0';
      // _hideList[6] = '0';
      setswitch4(v);
      _maxLimit--;
    }
    reset();
    // log(_maxLimit.toString());
    // log(_hideLocation3.toString());

    notifyListeners();
  }

  setHideLocation4(bool v) {
    _hideLocation4 = v;
    if (_hideLocation4) {
      // _hideList[1] = '5';
      // _hideList[4] = '5';
      // _hideList[7] = '5';
      setSwitch5(v);
      _maxLimit++;
    } else {
      // _hideList[1] = '0';
      // _hideList[4] = '0';
      // _hideList[7] = '0';
      setSwitch5(v);
      _maxLimit--;
    }
    reset();

    notifyListeners();
  }

  setHideLocation5(bool v) {
    _hideLocation5 = v;
    if (_hideLocation5) {
      // _hideList[2] = '6';
      // _hideList[5] = '6';
      // _hideList[8] = '6';
      setSwitch6(v);
      _maxLimit++;
    } else {
      // _hideList[2] = '0';
      // _hideList[5] = '0';
      // _hideList[8] = '0';
      setSwitch6(v);
      _maxLimit--;
    }
    reset();

    notifyListeners();
  }

  setHideLocation6(bool v) {
    _hideLocation6 = v;
    if (_hideLocation6) {
      
      setSwitch7(v);
      _maxLimit++;
    } else {
    
      setSwitch7(v);
      _maxLimit--;
    }
    reset();
    notifyListeners();
  }

  setHideLocation7(bool v) {
    _hideLocation7 = v;
    if (_hideLocation7) {
      // _hideList[0] = '8';
      // _hideList[4] = '8';
      // _hideList[8] = '8';
      setSwitch8(v);
    
      _maxLimit++;
    } else {
      // _hideList[0] = '0';
      // _hideList[4] = '0';
      // _hideList[8] = '0';
      setSwitch8(v);
      _maxLimit--;
    }
    // print(_hideList);
    reset();

    notifyListeners();
  }

  reset() {
    log("called");
    log(_maxLimit.toString());
    if (_maxLimit == 0) {
    
      const SnackBar snackBar =
          SnackBar(content: Text("atleast set in one location "));
      Snack.snackbarKey.currentState?.showSnackBar(snackBar);
    }
  }
}
