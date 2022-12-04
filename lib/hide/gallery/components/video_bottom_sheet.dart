import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project_first/hide/providers/video_provider.dart';
import 'package:my_project_first/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../utils/dialog.dart';

class VideoBottomSheet extends StatelessWidget {
  final File imgFile;
  const VideoBottomSheet({super.key, required this.imgFile});

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Container(
      height: size.height / 9,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
              onTap: () {
                Provider.of<VideoProvider>(context, listen: false)
                    .shareVideo(imgFile);
              },
              child: const Icon(Icons.share)),
          InkWell(
              onTap: () {
                //     .removeImageFromHive(__.currentImage!);
                CommonDialog().showAlert(context, 'Delete',
                    'Do you really want to delete this Image !? ',
                    button: 'Delete',
                    sideButton: 'No',
                    dismiss: true,
                    show: true, resetOnTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, oKonTap: () {
                  Provider.of<VideoProvider>(context, listen: false)
                      .deleteVideo(imgFile);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              child: const Icon(Icons.delete)),
          InkWell(
              onTap: () {
                Toast.show('Will be implemented soon :)',
                    duration: Toast.lengthLong, gravity: Toast.bottom);
              },
              child: const Icon(Icons.cloud))
        ],
      ), // This line set the transparent background
    );
  }
}
