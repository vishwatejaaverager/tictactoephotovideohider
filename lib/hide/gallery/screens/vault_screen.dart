import 'package:flutter/material.dart';
import 'package:my_project_first/hide/gallery/screens/photo/gallery_screen.dart';
import 'package:my_project_first/hide/gallery/screens/video/video_gallery_screen.dart';
import 'package:my_project_first/routes.dart';

import '../../../preferences/preferences.dart';

class VaultScreen extends StatefulWidget {
  static const id = Routes.vaultScreen;
  const VaultScreen({super.key});

  @override
  State<VaultScreen> createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  @override
  void initState() {
    UserPreference.setRun(true);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your secret Memories :) '),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.settingsScreen);
                },
                icon: const Icon(Icons.settings_outlined))
          ],
          bottom: TabBar(
            indicatorColor: Colors.grey,
            unselectedLabelColor: Colors.grey.withOpacity(0.5),
            labelColor: Colors.grey,
            tabs: const <Widget>[
              Tab(
                icon: Icon(
                  Icons.photo_sharp,
                  
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.video_camera_back,
                 
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            GalleryScreen(),
            VideoScreen(),
          ],
        ),
      ),
    );
  }
}
