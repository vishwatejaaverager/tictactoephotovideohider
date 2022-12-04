import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project_first/model/image/image_model.dart';
import 'package:my_project_first/routes.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../components/bottom_sheet_widget.dart';

class PhotoGallerView extends StatelessWidget {
  static const id = Routes.photoGalleryView;
  final PageController pageController;
  final int? imageIndex;
  final int? itemCount;
  final List<ImageModel>? images;
  PhotoGallerView({super.key, this.imageIndex, this.itemCount, this.images})
      : pageController = PageController(initialPage: imageIndex!);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PhotoViewGallery.builder(
            pageController: pageController,
            onPageChanged: (index) {
              //` __.setCurrentImage(index);
            },
            itemCount: itemCount,
            builder: ((context, index) {
              String path = images![index].imagePath;
              File img = File(path);

              return PhotoViewGalleryPageOptions(
                  onTapUp: (context, details, controllerValue) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return BottomSheetWidget(
                          imgFile: img,
                          imageModel: images![index],
                          index: index,
                        );
                      },
                    );
                  },
                  imageProvider: FileImage(img),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.contained * 4);
            })),
      ],
    ));
  }
}
