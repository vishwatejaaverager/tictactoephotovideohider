import 'dart:io';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_project_first/hide/gallery/components/video_bottom_sheet.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

class PotraitAndLandscapeScreen extends StatefulWidget {
  final File file;
  const PotraitAndLandscapeScreen({super.key, required this.file});

  @override
  State<PotraitAndLandscapeScreen> createState() =>
      _PotraitAndLandscapeScreenState();
}

class _PotraitAndLandscapeScreenState extends State<PotraitAndLandscapeScreen> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.file(widget.file)
      ..addListener(() {
        return setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((value) => videoPlayerController.play());

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    setAllOrientations();
    super.dispose();
  }

  Future setAllOrientations() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    await Wakelock.enable();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerBothWidget(
        videoPlayerController: videoPlayerController, file: widget.file);
  }
}

class VideoPlayerBothWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final File file;
  const VideoPlayerBothWidget(
      {super.key, required this.videoPlayerController, required this.file});

  @override
  State<VideoPlayerBothWidget> createState() => _VideoPlayerBothWidgetState();
}

class _VideoPlayerBothWidgetState extends State<VideoPlayerBothWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.videoPlayerController.value.isInitialized
        ? Container(
            alignment: Alignment.topCenter,
            child: buildVideo(),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildVideo() {
    return OrientationBuilder(builder: ((context, orientation) {
      final isPotrait = orientation == Orientation.portrait;
      return Center(
        child: Stack(
          fit: isPotrait ? StackFit.loose : StackFit.loose,
          children: [
            buildVideoPlayer(),
            Positioned.fill(
                child: AdvancedOverlayWidget(
                    
                    controller: widget.videoPlayerController,
                    onClickedFullScreen: () {
                      if (isPotrait) {
                        AutoOrientation.landscapeRightMode();
                      } else {
                        AutoOrientation.portraitUpMode();
                      }
                    },
                    file: widget.file,
                    
                    )),
          ],
        ),
      );
    }));
  }

  Widget buildVideoPlayer() {
    return AspectRatio(
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
      child: VideoPlayer(widget.videoPlayerController),
    );
  }
}

class AdvancedOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onClickedFullScreen;
  final File file;

  const AdvancedOverlayWidget(
      {super.key, required this.controller, required this.onClickedFullScreen, required this.file});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: ((context) {
              return VideoBottomSheet(
                imgFile: file,
              );
            }));
      },
      onDoubleTap: () {
        controller.value.isPlaying ? controller.pause() : controller.play();
      },
      child: Stack(
        children: [
          buildPlay(),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  Expanded(child: buildIndicator()),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: onClickedFullScreen,
                    child: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              )),
        ],
      ),
    );
  }

  Widget buildIndicator() => Container(
        margin: const EdgeInsets.all(8).copyWith(right: 0),
        height: 16,
        child: VideoProgressIndicator(
          controller,
          allowScrubbing: true,
        ),
      );

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
          color: Colors.black26,
          child: const Center(
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 70,
            ),
          ),
        );
}
