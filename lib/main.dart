import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:my_project_first/app_routers.dart';
import 'package:my_project_first/general_providers.dart';
import 'package:my_project_first/model/image_model.dart';
import 'package:my_project_first/on_boarding/screens/on_boarding_screen.dart';
import 'package:my_project_first/preferences/preferences.dart';
import 'package:my_project_first/tic_tac_toe/screens/tic_tac_toe_screen.dart';
import 'package:my_project_first/utils/app_theme.dart';

import 'package:provider/provider.dart';

//late ObjectBox objectBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ImageModelAdapter());
  await UserPreference.init();

  //await Hive.openBox('image-box');

  runApp(DevicePreview(
      enabled: false,
      tools: const [...DevicePreview.defaultTools],
      builder: ((context) {
        return MultiProvider(
          providers: generalProviders,
          child: const MyApp(),
        );
      })));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserPreference pref = UserPreference();
    bool a = pref.getToRun() ?? false;
    final theme = Provider.of<ThemeProvider>(context, listen: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onGenerateRoute: AppRouter.generateRoute,
      scaffoldMessengerKey: Snack.snackbarKey,
      themeMode: theme.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: !a ? const OnBoardingScreen() : const TictactoeScreen(),
    );
  }
}

class Snack {
  static final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  run() async {
    bool a = await IsFirstRun.isFirstRun();
    return a;
  }
}
