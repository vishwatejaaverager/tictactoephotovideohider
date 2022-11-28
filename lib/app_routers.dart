import 'package:flutter/material.dart';
import 'package:my_project_first/hide/gallery/screens/photo_view_gallery.dart';
import 'package:my_project_first/hide/gallery/screens/vault_screen.dart';
import 'package:my_project_first/hide/hide_location_settings/screens/hide_location_setting_screen.dart';
import 'package:my_project_first/hide/lock_screen/screens/lock_screen.dart';
import 'package:my_project_first/hide/profile_settings/screens/settings_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'hide/lock_screen/screens/lock_setting_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings route) {
    const PageTransitionType style = PageTransitionType.fade;

    switch (route.name) {
      case PhotoGallerView.id:
      
        return PageTransition(child:  PhotoGallerView(), type: style);
      case LockSettingScreen.id:
        return PageTransition(child: const LockSettingScreen(), type: style);
      case LockScreen.id:
        return PageTransition(child: const LockScreen(), type: style);
      case VaultScreen.id:
        return PageTransition(child: const VaultScreen(), type: style);
      case SettingsScreen.id:
        return PageTransition(child: const SettingsScreen(), type: style);
      case HiddenLocationSettingScreen.id:
        return PageTransition(
            child: const HiddenLocationSettingScreen(), type: style);
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No view defined for this route'),
            ),
          ),
        );
    }
  }
}
