import 'dart:io';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:my_project_first/hide/gallery/screens/photo/photo_view_gallery.dart';
import 'package:my_project_first/hide/providers/gallery_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../boxes.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late GalleryProvider galleryProvider;
  final controller = DragSelectGridViewController();

  @override
  void initState() {
    galleryProvider = Provider.of<GalleryProvider>(context, listen: false);
    controller.addListener(scheduleRebuild);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //galleryProvider.getImageshive();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    galleryProvider = Provider.of<GalleryProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //galleryProvider.getImagesFromFile();
      galleryProvider.blockScreenshots();
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Boxes.getImageModelBox().listenable(),
        builder: ((context, value, child) {
          final isSelecting = controller.value.selectedIndexes.toList();
          // __.setMultiselect(isSelecting);
          final sel = controller.value.isSelecting;
          if (sel) {
            Provider.of<GalleryProvider>(context, listen: false)
                .setMultiselect(isSelecting);
          }
          Provider.of<GalleryProvider>(context, listen: false)
              .setIsSelecting(sel);
          //log(isSelecting.toString());
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DragSelectGridView(
                      gridController: controller,
                      itemCount: value.values.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4),
                      itemBuilder: (context, index, selected) {
                        String path = value.values.toList()[index].imagePath;
                        File imag = File(path);

                        if (value.values.isEmpty) {
                          // log(__.imagePaths[index].toString());
                          return const Text("please do add images");
                        } else {
                          return InkWell(
                            onTap: () {
                              // __.setIsSelecting(sel);
                              // __.setCurrentImage(index);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => PhotoGallerView(
                                            imageIndex: index,
                                            images: value.values.toList(),
                                            itemCount: value.values.length,
                                          ))));
                            },
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 100.h,
                                  width: 100.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.file(
                                      imag,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                selected
                                    ? InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 100.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color:
                                                  Colors.blue.withOpacity(0.5)),
                                          child: const Center(
                                            child: Icon(Icons.done),
                                          ),
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                galleryProvider.saveImagesInFiles();
              },
              child: const Icon(Icons.add_a_photo),
            ),
          );
        }));
  }

  void scheduleRebuild() => setState(() {});
}
