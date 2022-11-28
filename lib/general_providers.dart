import 'package:my_project_first/hide/providers/gallery_provider.dart';
import 'package:my_project_first/hide/providers/hide_location_provider.dart';
import 'package:my_project_first/hide/providers/lock_screen_provider.dart';
import 'package:my_project_first/hide/providers/settings_provider.dart';
import 'package:my_project_first/tic_tac_toe/providers/tic_tac_toe_provider.dart';
import 'package:my_project_first/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> generalProviders = [

  
  ChangeNotifierProvider<LockScreenProvider>(
    create: (_) => LockScreenProvider(),
  ),

  ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider(),
  ),
  ChangeNotifierProvider<TicTacToeProvider>(
    create: (_) => TicTacToeProvider(),
  ),
  ChangeNotifierProvider<GalleryProvider>(
    create: (_) => GalleryProvider(),
  ),
  ChangeNotifierProvider<SettingsProvider>(
    create: (_) => SettingsProvider(),
  ),
  ChangeNotifierProvider<HideLocationProvider>(
    create: (_) => HideLocationProvider(),
  ),
];
