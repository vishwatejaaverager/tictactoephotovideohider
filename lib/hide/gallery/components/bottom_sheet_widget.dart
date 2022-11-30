import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project_first/hide/providers/gallery_provider.dart';
import 'package:my_project_first/utils/dialog.dart';
import 'package:my_project_first/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../../boxes.dart';

class BottomSheetWidget extends StatelessWidget {
  final File imgFile;
  const BottomSheetWidget({
    Key? key,
    required this.imgFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Boxes.getFavs;
    ToastContext().init(context);

    return Consumer<GalleryProvider>(builder: ((_, __, ___) {
      return Container(
        height: size.height / 9,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  Provider.of<GalleryProvider>(context, listen: false)
                      .shareImage(imgFile);
                  //         .shareImage();
                },
                child: const Icon(Icons.share)),
            InkWell(
                onTap: () {
                  Provider.of<GalleryProvider>(context, listen: false)
                      .addImagetoFav(imgFile.path);
                },
                child: Icon(
                  Icons.favorite,
                  color: box.values.contains(imgFile.path)
                      ? Colors.red
                      : Colors.white,
                )),
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
                    Provider.of<GalleryProvider>(context, listen: false)
                        .deleteImage(imgFile, __.currentImage!);
                    // Provider.of<GalleryProvider>(context, listen: false)
                    //     .removeImageFromHive(__.currentImage!);
                    // appToast(context, 'image deleted :)');
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
    }));
  }
}
