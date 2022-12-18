import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_project_first/main.dart';
import 'package:my_project_first/preferences/preferences.dart';
import 'package:my_project_first/routes.dart';
import 'package:my_project_first/tic_tac_toe/providers/tic_tac_toe_provider.dart';
import 'package:my_project_first/tic_tac_toe/screens/tic_tac_toe_screen.dart';
import 'package:my_project_first/utils/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_project_first/utils/dialog.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import 'hide/providers/hide_location_provider.dart';
import 'hide/providers/lock_screen_provider.dart';

class SplashScreen extends StatefulWidget {
  static const id = Routes.splashScreen;
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late HideLocationProvider hideLocationProvider;
  late TicTacToeProvider tacToeProvider;
  late LockScreenProvider lockScreenProvider;
  List? hideLocation;
  UserPreference preference = UserPreference();
  bool? torun;
  late bool? run;
  @override
  void initState() {
    hideLocationProvider =
        Provider.of<HideLocationProvider>(context, listen: false);
    tacToeProvider = Provider.of<TicTacToeProvider>(context, listen: false);
    lockScreenProvider =
        Provider.of<LockScreenProvider>(context, listen: false);
    torun = preference.getToRun();
    run = preference.getRun();
    bool a = preference.getToRun() ?? false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      if (torun ?? true) {
        hideLocationProvider.setBoolsofSwitches(context);

        //  log("its running");
        //hideLocationProvider.getDefaultValues();
      }
      if (run ?? false) {
        hideLocationProvider.gethideList();
        lockScreenProvider.getLockPass();
      }

      //hideLocation = hideLocationProvider.hideList;
      //tacToeProvider.setHideListTicTac(hideLocation!);
    });
    Provider.of<TicTacToeProvider>(context, listen: false).isFirstRunl().then((value){
      if ((value)) {
        log("show");
        Future.delayed(const Duration(seconds: 2)).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowCaseWidget(onFinish: () {
                      Provider.of<TicTacToeProvider>(context, listen: false)
                          .setShowCaseText('');
                      CommonDialog().showAlert(
                          Snack.navigatorKey.currentState!.overlay!.context,
                          "X has won",
                          "Double tap on ok to when this appears :)",
                          dismiss: true);
                    }, builder: Builder(builder: ((context) {
                      return const TictactoeScreen();
                    })))),
          );
        });
      } else {
        log("not show");
        Future.delayed(const Duration(seconds: 3)).then((value) =>
            Navigator.pushNamedAndRemoveUntil(
                context, TictactoeScreen.id, (route) => false));
      }
    } );

    

    super.initState();
  }

  @override
  void didChangeDependencies() {
    hideLocationProvider =
        Provider.of<HideLocationProvider>(context, listen: false);
    tacToeProvider = Provider.of<TicTacToeProvider>(context, listen: false);
    lockScreenProvider =
        Provider.of<LockScreenProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage("assets/tac/splash.png"),
              height: 200,
            ),
            SpinKitWanderingCubes(
              color: Colors.white,
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
