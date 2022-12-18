import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:my_project_first/hide/gallery/screens/vault_screen.dart';
import 'package:my_project_first/hide/providers/lock_screen_provider.dart';
import 'package:my_project_first/routes.dart';
import 'package:provider/provider.dart';

class LockScreen extends StatefulWidget {
  static const id = Routes.lockScreen;
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/profile/lock.jpg',
                  ))),
          child: Consumer<LockScreenProvider>(
            builder: (context, value, child) {
              return ScreenLock(
                correctString: value.pass,
                onUnlocked: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, VaultScreen.id, (route) => false);
                },
              );
            },
          )),
    );
  }
}
