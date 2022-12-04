import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project_first/boxes.dart';
import 'package:my_project_first/model/image/image_model.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../utils/dialog.dart';
import '../../../utils/utils.dart';
import '../../providers/gallery_provider.dart';

class BottomSheetWidget extends StatelessWidget {
  final File imgFile;
  final ImageModel imageModel;
  final int index;
  const BottomSheetWidget({
    Key? key,
    required this.imgFile,
    required this.imageModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final box = Boxes.getFavs;
    ToastContext().init(context);

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
          ValueListenableBuilder(
              valueListenable: Boxes.getImageModelBox().listenable(),
              builder: ((context, value, child) {
                var a = value.values.toList();
                var b = a[index];
                return InkWell(
                    onTap: () {
                      b.isFav
                          ? Provider.of<GalleryProvider>(context, listen: false)
                              .removeFav(imgFile.path)
                          : Provider.of<GalleryProvider>(context, listen: false)
                              .addFav(imgFile.path);
                    },
                    child: Icon(
                      Icons.favorite,
                      color: b.isFav ? Colors.red : Colors.white,
                    ));
              })),
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
                      .deleteImage(imgFile);
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
