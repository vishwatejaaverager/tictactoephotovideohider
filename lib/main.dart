import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:my_project_first/app_routers.dart';
import 'package:my_project_first/general_providers.dart';
import 'package:my_project_first/model/image/image_model.dart';
import 'package:my_project_first/model/videos/video_model.dart';

import 'package:my_project_first/on_boarding/screens/on_boarding_screen.dart';
import 'package:my_project_first/preferences/preferences.dart';
import 'package:my_project_first/splash_screen.dart';
import 'package:my_project_first/tic_tac_toe/screens/tic_tac_toe_screen.dart';
import 'package:my_project_first/utils/app_theme.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

//late ObjectBox objectBox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await UserPreference.init();
  Hive.registerAdapter(ImageModelAdapter());
  Hive.registerAdapter(VideoModelAdapter());
  await Hive.openBox<ImageModel>('images-path-box');
  await Hive.openBox<VideoModel>('videos-path-box');

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
    return Sizer(builder: ((context, orientation, deviceType) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          onGenerateRoute: AppRouter.generateRoute,
          scaffoldMessengerKey: Snack.snackbarKey,
          navigatorKey: Snack.navigatorKey,
          themeMode: theme.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: !a ? const OnBoardingScreen() : const SplashScreen());
    }));
  }
}

class Snack {
  static final GlobalKey<ScaffoldMessengerState> snackbarKey =
      GlobalKey<ScaffoldMessengerState>();
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  run() async {
    bool a = await IsFirstRun.isFirstRun();
    return a;
  }
}
