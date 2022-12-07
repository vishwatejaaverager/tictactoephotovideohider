import 'package:flutter/material.dart';
import 'package:my_project_first/hide/providers/settings_provider.dart';
import 'package:my_project_first/routes.dart';
import 'package:my_project_first/utils/app_theme.dart';
import 'package:my_project_first/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../gallery/screens/photo/favourite_screen.dart';
import '../components/settings_heading_widget.dart';
import '../components/settings_tile_widget.dart';

class SettingsScreen extends StatefulWidget {
  static const id = Routes.settingsScreen;
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ThemeProvider themeProvider;

  @override
  void initState() {
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (_, __, ___) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (() => Navigator.pop(context)),
                    child: Container(
                        margin: const EdgeInsets.only(left: 16, top: 16),
                        child: const Icon(Icons.arrow_back)),
                  ),
                  sbh(8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'Settings',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SettingHeadingTile(
                    text: "Content",
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SettingsTileWidget(
                          text: "favourites",
                          icon: const Icon(Icons.heart_broken),
                          onpressed: () {
                            Navigator.pushNamed(
                                context, FavouriteImageScreen.id);
                          },
                        ),
                        sbh(16),
                        SettingsTileWidget(
                          text: "Cloud",
                          icon: const Icon(Icons.cloud),
                          onpressed: () {
                            appToast(context, "will be implemented soon");
                          },
                        )
                      ],
                    ),
                  ),
                  const SettingHeadingTile(
                    text: "Preferences",
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Consumer<ThemeProvider>(
                            builder: ((context, value, child) {
                          return SettingsTileWidget(
                            text: "Darkmode",
                            icon: const Icon(Icons.dark_mode),
                            suffix: Switch(
                                value: value.isDarkMode,
                                onChanged: (v) {
                                  value.toggle(v);
                                }),
                          );
                        })),
                        sbh(16),
                        SettingsTileWidget(
                          text: "Hide location",
                          icon: const Icon(Icons.lock),
                          onpressed: () {
                            Navigator.pushNamed(
                                context, Routes.hideLocationScreen);
                          },
                        ),
                        sbh(32),
                        SettingsTileWidget(
                          text: "Change Passcode",
                          icon: const Icon(Icons.password_outlined),
                          onpressed: () {
                            Navigator.pushNamed(
                                context, Routes.lockScreenSetting);
                          },
                        ),
                       

                      ],
                    ),
                  ),
                   const SettingHeadingTile(
                    text: "About",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: SettingsTileWidget(
                      text: "About us",
                      icon: const Icon(Icons.person),
                      onpressed: () {
                        Navigator.pushNamed(context, Routes.aboutUs);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
