import 'dart:io';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:my_project_first/hide/gallery/screens/photo/photo_view_gallery.dart';
import 'package:my_project_first/hide/providers/gallery_provider.dart';
import 'package:my_project_first/model/image/image_model.dart';
import 'package:my_project_first/routes.dart';
import 'package:provider/provider.dart';

import '../../../../boxes.dart';

class FavouriteImageScreen extends StatefulWidget {
  static const id = Routes.favScreen;
  const FavouriteImageScreen({super.key});

  @override
  State<FavouriteImageScreen> createState() => _FavouriteImageScreenState();
}

class _FavouriteImageScreenState extends State<FavouriteImageScreen> {
  late GalleryProvider galleryProvider;
  @override
  void initState() {
    galleryProvider = Provider.of<GalleryProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  void didChangeDependencies() {
    galleryProvider = Provider.of<GalleryProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Your Favourite Secret Memories :)",
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: ValueListenableBuilder(
            valueListenable: Boxes.getImageModelBox().listenable(),
            builder: ((context, value, child) {
              List<ImageModel> a = value.values
                  .where((element) => element.isFav == true)
                  .toList();
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: a.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4),
                          itemBuilder: (BuildContext context, int index) {
                            File imag = File(a[index].imagePath);
                            if (value.values.isEmpty) {
                              //log(__.favImagePaths[index].toString());
                              return const Text("please do add images");
                            } else {
                              return InkWell(
                                onTap: () {
                                  // __.setCurrentImage(index);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              PhotoGallerView(
                                              
                                                imageIndex: index,
                                                images: a,
                                                itemCount: a.length,
                                              ))));
                                },
                                child: SizedBox(
                                  height: 100,
                                  child: Image.file(
                                    imag,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                  ),
                ],
              );
            })));
  }
}

//  Consumer<GalleryProvider>(
//         builder: (_, __, ___) {
//           return Column(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GridView.builder(
//                       itemCount: __.favImagePaths.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3,
//                               mainAxisSpacing: 4,
//                               crossAxisSpacing: 4),
//                       itemBuilder: (BuildContext context, int index) {
//                         String path = __.favImagePaths[index].imagePath;
//                         File imag = File(path);
//                         if (__.favImagePaths.isEmpty) {
//                           log(__.favImagePaths[index].toString());
//                           return const Text("please do add images");
//                         } else {
//                           return InkWell(
//                             onTap: () {
//                               __.setCurrentImage(index);
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: ((context) => PhotoGallerView(
//                                             imageIndex: index,
//                                             images: __.favImagePaths,
//                                             itemCount: __.favImagePaths.length,
//                                           ))));
//                             },
//                             child: SizedBox(
//                               height: 100,
//                               child: Image.file(
//                                 imag,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         }
//                       }),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),