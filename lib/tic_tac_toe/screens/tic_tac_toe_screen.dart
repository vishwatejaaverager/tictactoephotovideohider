import 'package:flutter/material.dart';
import 'package:my_project_first/hide/providers/hide_location_provider.dart';
import 'package:my_project_first/tic_tac_toe/providers/tic_tac_toe_provider.dart';
import 'package:my_project_first/utils/colors.dart';
import 'package:my_project_first/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../preferences/preferences.dart';
import '../../routes.dart';

class TictactoeScreen extends StatefulWidget {
  static const id = Routes.ticTacToeScreen;
  const TictactoeScreen({super.key});

  @override
  State<TictactoeScreen> createState() => _TictactoeScreenState();
}

class _TictactoeScreenState extends State<TictactoeScreen> {
  late HideLocationProvider hideLocationProvider;
  final keyOne = GlobalKey();
  final keyTwo = GlobalKey();
  final keyThree = GlobalKey();
  final keyFour = GlobalKey();
  UserPreference preference = UserPreference();
  // late TicTacToeProvider tacToeProvider;
  // late LockScreenProvider lockScreenProvider;
  // List? hideLocation;
  // UserPreference preference = UserPreference();
  // bool? torun;
  // late bool? run;

  // @override
  // void dispose() {
  //   Hive.close();
  //   super.dispose();
  // }

  // startShowCase() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {

  //   });
  // }

  @override
  void initState() {
    hideLocationProvider =
        Provider.of<HideLocationProvider>(context, listen: false);
    // startShowCase();
    // ShowCaseWidget.of(context).startShowCase([_keyOne]);
    

    if (Provider.of<TicTacToeProvider>(context, listen: false).isFirstRun) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        ShowCaseWidget.of(context).startShowCase([keyOne,keyTwo,keyThree]);
      });
    }

    // tacToeProvider = Provider.of<TicTacToeProvider>(context, listen: false);
    // lockScreenProvider =
    //     Provider.of<LockScreenProvider>(context, listen: false);
    // torun = preference.getToRun();
    // run = preference.getRun();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Add Your Code here.

    //   if (torun ?? true) {
    //     hideLocationProvider.setBoolsofSwitches(context);

    //     log("its running");
    //     //hideLocationProvider.getDefaultValues();
    //   }
    //   if (run ?? false) {

    //     hideLocationProvider.gethideList();
    //     lockScreenProvider.getLockPass();
    //   }
    //   //hideLocation = hideLocationProvider.hideList;
    //   //tacToeProvider.setHideListTicTac(hideLocation!);
    // });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    hideLocationProvider =
        Provider.of<HideLocationProvider>(context, listen: false);
    // tacToeProvider = Provider.of<TicTacToeProvider>(context, listen: false);
    // lockScreenProvider =
    //     Provider.of<LockScreenProvider>(context, listen: false);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TicTacToeProvider>(builder: ((_, __, ___) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              __.isOturn ? "O's turn" : "X's turn",
              style: const TextStyle(fontSize: 32, color: Colors.white54),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        __.onTap(index, context, hideLocationProvider);
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: size.height / 8,
                            width: size.width / 6,
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  width: 2, color: Colors.grey[800]!),
                              right: BorderSide(
                                  width: 2, color: Colors.grey[800]!),
                              bottom: BorderSide(
                                  width: 2, color: Colors.grey[800]!),
                              left: BorderSide(
                                  width: 2, color: Colors.grey[800]!),
                            )),
                            child: Center(
                              child: Text(
                                __.tictac[index],
                                style:
                                    TextStyle(color: whiteColor, fontSize: 16),
                              ),
                            ),
                          ),

                          Visibility(
                              visible: index == 0 && __.isFirstRun,
                              child: Showcase(
                                  key: keyOne,
                                  description: "Make X win",
                                  child: Center(child: Text(__.showCaseText)))),
                          Visibility(
                              visible: index == 1 && __.isFirstRun,
                              child: Showcase(
                                  key: keyTwo,
                                  description: "Make X win",
                                  child: Center(child: Text(__.showCaseText)))),
                          Visibility(
                              visible: index == 2 && __.isFirstRun,
                              child: Showcase(
                                  key: keyThree,
                                  description: "Make X win",
                                  child: Center(child: Text(__.showCaseText))))

                          // (preference.getToRun() ?? false)
                          //     ? Visibility(
                          //         visible: index == 2 && preference.getToRun()!,
                          //         child: Showcase(
                          //             key: keyThree,
                          //             description: "Make X win",
                          //             child:
                          //                 Center(child: Text(__.showCaseText))))
                          //     : const SizedBox()
                          // index == 0
                          //     ? Showcase(
                          //         key: keyOne,
                          //         description: "description",
                          //         child: SizedBox(
                          //           height: size.height / 8,
                          //           width: size.width / 6,
                          //         ))
                          //     : const SizedBox()
                        ],
                      ),
                    );
                  })),
            ),
            // TextButton(
            //     onPressed: () async {
            //       try {
            //         await Permission.storage.request();
            //       } catch (e) {
            //         log(e.toString());
            //       }
            //     },
            //     child: const Text('test'))
          ],
        ),
      );
    }));
  }

  // void request() async {
  //   var status = await Permission.contacts.request();
  //   if (status.isGranted) {
  //     log("granted");
  //   } else if (status.isDenied) {
  //     log("denied");
  //   }
  // }

  // Future<void> requestPermission(Permission permission) async {}
}
