import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_project_first/hide/gallery/screens/photo_view_gallery.dart';
import 'package:my_project_first/hide/providers/gallery_provider.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late GalleryProvider galleryProvider;

  @override
  void initState() {
    galleryProvider = Provider.of<GalleryProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      galleryProvider.getImageshive();
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    galleryProvider = Provider.of<GalleryProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      galleryProvider.getImageshive();
      galleryProvider.blockScreenshots();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryProvider>(builder: ((_, __, ___) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: __.images.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4),
                    itemBuilder: (BuildContext context, int index) {
                      if (__.images.isEmpty) {
                        log(__.images[index].toString());
                        return const Text("please do add images");
                      } else {
                        return InkWell(
                          onTap: () {
                            __.setCurrentImage(index);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => PhotoGallerView(
                                          imageIndex: index,
                                          images: __.images,
                                          itemCount: __.images.length,
                                        ))));
                          },
                          child: SizedBox(
                            height: 100,
                            child: Image.memory(
                              __.images[index].images,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            galleryProvider.saveImagesInHiveDb();
          },
          child: const Icon(Icons.add_a_photo),
        ),
      );
    }));
  }
}
