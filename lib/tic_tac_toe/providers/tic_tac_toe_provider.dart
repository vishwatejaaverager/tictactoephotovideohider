import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:my_project_first/hide/lock_screen/screens/lock_screen.dart';
import 'package:my_project_first/hide/providers/hide_location_provider.dart';
import 'package:my_project_first/utils/dialog.dart';

class TicTacToeProvider with ChangeNotifier {
  final bool _isXturn = true;
  bool get isXturn => _isXturn;

  bool _isFirstRunv = false;
  bool get isFirstRun => _isFirstRunv;

  bool _isOturn = true;
  bool get isOturn => _isOturn;

  int _filledBoxes = 0;
  int get filledBoxes => _filledBoxes;

  String _showCaseText = 'X';
  String get showCaseText => _showCaseText;

  setShowCaseText(String s) {
    _showCaseText = s;
    notifyListeners();
  }

  Future<bool> isFirstRunl() async {
    log("came to run");
    bool isFirst = await IsFirstRun.isFirstRun();
    _isFirstRunv = isFirst;
    log(isFirst.toString());
    return isFirst;
  }

  // ignore: prefer_final_fields
  //  List _hideListTictac = [
  //   ['0', '0', '0'],
  //   ['0', '0', '0'],
  //   ['0', '0', '0']
  // ];

  // List get hideListTicTac => _hideListTictac;

  // setHideListTicTac(List a) {
  //   _hideListTictac = a;

  // }

  final List _tictac = ['', '', '', '', '', '', '', '', ''];
  List get tictac => _tictac;

  // getPermission(BuildContext context) async {
  //   log("came");
  //   try {
  //     PermissionStatus file = await Permission.storage.request();
  //     if (file == PermissionStatus.granted) {
  //       //appToast(context, 'thank you :)');
  //     } else {
  //       //appToast(context, "Plaese do grant :(");
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  onTap(int index, BuildContext context,
      HideLocationProvider hideLocationProvider) {
    if (_isOturn && _tictac[index] == '') {
      _tictac[index] = 'O';
      _filledBoxes++;
      _isOturn = false;
      log("called o");
      notifyListeners();
    } else if (!_isOturn && _tictac[index] == '') {
      _tictac[index] = 'X';
      _filledBoxes++;
      _isOturn = true;
      log("called x ");
      notifyListeners();
    }
    checkWinner(context, hideLocationProvider);
    // _isOturn = !_isOturn;
    log('${_isOturn}turn');
  }

  void checkWinner(
      BuildContext context, HideLocationProvider hideLocationProvider) {
    // Checking rows
    if (_tictac[0] == _tictac[1] &&
        _tictac[0] == _tictac[2] &&
        _tictac[0] != '') {
      CommonDialog().showAlert(
        context,
        _tictac[0],
        "Has won the game  :)",
        oKonTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
        onLongPressed: () {
          log("pressesd");
          if (_tictac[0] == 'X') {
            if (hideLocationProvider.hideLocation2) {
              log("came");
              Navigator.pushNamedAndRemoveUntil(
                  context, LockScreen.id, (route) => false);
            }
          }
        },
        resetOnTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
      );
    }
    if (_tictac[3] == _tictac[4] &&
        _tictac[3] == _tictac[5] &&
        _tictac[3] != '') {
      CommonDialog().showAlert(
        context,
        _tictac[3],
        "Has won the game  :)",
        oKonTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
        onLongPressed: () {
          if (_tictac[3] == 'X') {
            if (hideLocationProvider.hideLocation1) {
              log("came");
              Navigator.pushNamedAndRemoveUntil(
                  context, LockScreen.id, (route) => false);
            }
          }
        },
        resetOnTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
      );
    }
    if (_tictac[6] == _tictac[7] &&
        _tictac[6] == _tictac[8] &&
        _tictac[6] != '') {
      CommonDialog().showAlert(
        context,
        _tictac[6],
        "Has won the game  :)",
        oKonTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
        onLongPressed: () {
          log("clicked");
          if (_tictac[6] == 'X') {
            if (hideLocationProvider.hideLocation) {
              log("came");
              Navigator.pushNamedAndRemoveUntil(
                  context, LockScreen.id, (route) => false);
            }
          }
        },
        resetOnTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
      );
    }

    // Checking Column
    if (_tictac[0] == _tictac[3] &&
        _tictac[0] == _tictac[6] &&
        _tictac[0] != '') {
      CommonDialog().showAlert(
        context,
        _tictac[0],
        "Has won the game  :)",
        oKonTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
        onLongPressed: () {
          if (_tictac[0] == 'X') {
            if (hideLocationProvider.hideLocation3) {
              log("came");
              Navigator.pushNamedAndRemoveUntil(
                  context, LockScreen.id, (route) => false);
            }
          }
        },
        resetOnTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
      );
    }
    if (_tictac[1] == _tictac[4] &&
        _tictac[1] == _tictac[7] &&
        _tictac[1] != '') {
      CommonDialog().showAlert(
        context,
        _tictac[1],
        "Has won the game  :)",
        oKonTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
        onLongPressed: () {
          if (_tictac[1] == 'X') {
            if (hideLocationProvider.hideLocation4) {
              log("came");
              Navigator.pushNamedAndRemoveUntil(
                  context, LockScreen.id, (route) => false);
            }
          }
        },
        resetOnTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
      );
    }
    if (_tictac[2] == _tictac[5] &&
        _tictac[2] == _tictac[8] &&
        _tictac[2] != '') {
      CommonDialog().showAlert(
        context,
        _tictac[2],
        "Has won the game  :)",
        oKonTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
        onLongPressed: () {
          if (_tictac[2] == 'X') {
            if (hideLocationProvider.hideLocation5) {
              log("came");
              Navigator.pushNamedAndRemoveUntil(
                  context, LockScreen.id, (route) => false);
            }
          }
        },
        resetOnTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
      );
    }

    // Checking Diagonal
    if (_tictac[0] == _tictac[4] &&
        _tictac[0] == _tictac[8] &&
        _tictac[0] != '') {
      CommonDialog().showAlert(
        context,
        _tictac[0],
        "Has won the game  :)",
        oKonTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
        onLongPressed: () {
          if (_tictac[0] == 'X') {
            if (hideLocationProvider.hideLocation7) {
              log("came");
              Navigator.pushNamedAndRemoveUntil(
                  context, LockScreen.id, (route) => false);
            }
          }
        },
        resetOnTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
      );
    }
    if (_tictac[2] == _tictac[4] &&
        _tictac[2] == _tictac[6] &&
        _tictac[2] != '') {
      CommonDialog().showAlert(
        context,
        _tictac[0],
        "Has won the game  :)",
        oKonTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
        onLongPressed: () {
          if (_tictac[2] == 'X') {
            if (hideLocationProvider.hideLocation6) {
              log("came");
              Navigator.pushNamedAndRemoveUntil(
                  context, LockScreen.id, (route) => false);
            }
          }
        },
        resetOnTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
      );
    } else if (filledBoxes == 9) {
      CommonDialog().showAlert(
        context,
        "Draw :)",
        "",
        oKonTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
        onLongPressed: () {},
        resetOnTap: () {
          _clearBoard();
          Navigator.pop(context);
        },
      );
    }
  }

  void _clearBoard() {
    for (int i = 0; i < 9; i++) {
      _tictac[i] = '';
    }

    _filledBoxes = 0;
    notifyListeners();
  }
}
