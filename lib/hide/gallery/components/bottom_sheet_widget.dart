import 'package:flutter/material.dart';
import 'package:my_project_first/hide/providers/gallery_provider.dart';
import 'package:my_project_first/model/image_model.dart';
import 'package:my_project_first/utils/dialog.dart';
import 'package:my_project_first/utils/utils.dart';
import 'package:provider/provider.dart';

class BottomSheetWidget extends StatelessWidget {
  final ImageModel imageModell;
  const BottomSheetWidget({
    Key? key,
    required this.imageModell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryProvider>(builder: ((_, __, ___) {
      return Container(
        height: size.height / 9,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  __.isSharing
                   ? const Center(child: CircularProgressIndicator())
                      : Provider.of<GalleryProvider>(context, listen: false)
                          .shareImage(imageModell.images);
                     
                },
                child: const Icon(Icons.share)),
            const Icon(Icons.favorite),
            InkWell(
                onTap: () {
                  // Provider.of<GalleryProvider>(context, listen: false)
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
                        .removeImageFromHive(__.currentImage!);
                    appToast(context, 'image deleted :)');
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                },
                child: const Icon(Icons.delete)),
            const Icon(Icons.cloud)
          ],
        ), // This line set the transparent background
      );
    }));
  }
}
