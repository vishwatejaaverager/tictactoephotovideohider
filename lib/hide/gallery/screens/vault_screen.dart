import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_project_first/hide/gallery/screens/photo/gallery_screen.dart';
import 'package:my_project_first/hide/gallery/screens/video/video_gallery_screen.dart';
import 'package:my_project_first/hide/providers/gallery_provider.dart';
import 'package:my_project_first/routes.dart';
import 'package:my_project_first/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../preferences/preferences.dart';
import '../../../utils/dialog.dart';

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
            Provider.of<GalleryProvider>(context, listen: true).isSelecting
                ? Consumer<GalleryProvider>(builder: ((_, __, ___) {
                    return PopupMenuButton(itemBuilder: ((context) {
                      return [
                        PopupMenuItem<Int>(
                            child: InkWell(
                          onTap: () {
                            Provider.of<GalleryProvider>(context, listen: false)
                                .shareMultiple(__.multiSelect);
                          },
                          child: Row(
                            children: [
                              const Text("Share"),
                              sbw(4),
                              const Icon(Icons.share)
                            ],
                          ),
                        )),
                        PopupMenuItem<Int>(
                            child: InkWell(
                          onTap: () {
                            log("message");

                            CommonDialog().showAlert(context, 'Delete',
                                'Do you really want to delete this Image !? ',
                                button: 'Delete',
                                sideButton: 'No',
                                dismiss: true,
                                show: true, resetOnTap: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }, oKonTap: () {
                              Provider.of<GalleryProvider>(context,
                                      listen: false)
                                  .deleteMultipleImages(__.multiSelect);

                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          },
                          child: Row(
                            children: [
                              const Text("Delete"),
                              sbw(4),
                              const Icon(Icons.delete)
                            ],
                          ),
                        )),
                      ];
                    }));
                  }))
                : IconButton(
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
