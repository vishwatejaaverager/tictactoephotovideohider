import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_project_first/hide/providers/gallery_provider.dart';
import 'package:my_project_first/model/image_model.dart';
import 'package:my_project_first/routes.dart';
import 'package:my_project_first/utils/colors.dart';
import 'package:my_project_first/utils/utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../components/bottom_sheet_widget.dart';

class PhotoGallerView extends StatelessWidget {
  static const id = Routes.photoGalleryView;
  final PageController pageController;
  final int? imageIndex;
  final int? itemCount;
  final List? images;
  PhotoGallerView({super.key, this.imageIndex, this.itemCount, this.images})
      : pageController = PageController(initialPage: imageIndex!);

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryProvider>(builder: ((_, __, ___) {
      return Scaffold(
          body: Stack(
        children: [
          PhotoViewGallery.builder(
              pageController: pageController,
              onPageChanged: (index) {
                __.setCurrentImage(index);
              },
              itemCount: itemCount,
              builder: ((context, index) {
                ImageModel img = images![index];
                
                return PhotoViewGalleryPageOptions(
                    onTapUp: (context, details, controllerValue) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return  BottomSheetWidget(imageModell: img,);
                        },
                      );
                    },
                    imageProvider: MemoryImage(img.images),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 4);
              })),
        ],
      ));
    }));
  }
}
