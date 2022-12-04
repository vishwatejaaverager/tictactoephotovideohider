import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project_first/hide/gallery/screens/video/potrait_and_landscape.dart';
import 'package:my_project_first/hide/providers/video_provider.dart';
import 'package:my_project_first/routes.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
class VideoScreen extends StatefulWidget {
  static const id = Routes.videoScreen;
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoProvider videoProvider;

  @override
  void initState() {
    videoProvider = Provider.of<VideoProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      videoProvider.getVideoFilesFromHive();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    videoProvider = Provider.of<VideoProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(builder: ((_, __, ___) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            videoProvider.storeThumnailsofVideos();
          },
          child: const Icon(Icons.camera),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: __.videoModelVids.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4),
                    itemBuilder: (BuildContext context, int index) {
                      File imag = File(__.videoModelVids[index].videoPicPath);
                      if (__.videoModelVids.isEmpty) {
                        log(__.videoModelVids[index].toString());
                        return const Text("please do add images");
                      } else {
                        return InkWell(
                            onTap: () {
                              // __.setCurrentImage(index);
                              File file =
                                  File(__.videoModelVids[index].videoPath);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          PotraitAndLandscapeScreen(
                                              file: file))));
                            },
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 100.h,
                                  width: 100.w,
                                  child: Image.file(
                                    imag,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const Center(
                                    child: Icon(
                                  Icons.play_arrow,
                                  size: 32,
                                ))
                              ],
                            ));
                      }
                    }),
              ),
            )
          ],
        ),
      );
    }));
  }
}
