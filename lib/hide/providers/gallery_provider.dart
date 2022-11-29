import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string_generator/random_string_generator.dart';

class GalleryProvider with ChangeNotifier {
  //final List<XFile> _sharableImages = [];

  final bool _isSharing = false;
  bool get isSharing => _isSharing;

  List<dynamic> _imagePaths = [];
  List<dynamic> get imagePaths => _imagePaths;

  final String _pickHiveBox = 'image-box';
  String get pickHiveBox => _pickHiveBox;

  List<XFile> _selectedImages = [];
  List<XFile>? get selectedImages => _selectedImages;

  int? _currentImage;
  int? get currentImage => _currentImage;

  setCurrentImage(int s) {
    _currentImage = s;
    log('${_currentImage}this is current image ');
    notifyListeners();
  }

  clearMultipleImages() {
    _selectedImages.clear();

    log("images cleared");
  }

  blockScreenshots() {
    log("caaled ss secure");
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  // shareImage(Uint8List image) async {
  //   try {
  //     _isSharing = true;
  //     log('$_isSharing is sharing');
  //     Box<ImageModel> box = await Hive.openBox<ImageModel>(pickHiveBox);
  //     final directory = await getApplicationDocumentsDirectory();
  //     String path = directory.path;
  //     log('$path this directory path');
  //     File a = await File(box.path!).writeAsBytes(image);
  //     var g = RandomStringGenerator(fixedLength: 5);
  //     String h = g.generate();
  //     final File newim = await a.copy('$path/$h.jpg');
  //     log(newim.toString());
  //     XFile file = XFile(newim.path);
  //     await Share.shareXFiles([file]);
  //     _isSharing = false;
  //     log('$_isSharing is sharing');
  //     notifyListeners();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // pickMultipleImages() async {
  //   final ImagePicker picker = ImagePicker();
  //   try {
  //     List<XFile>? images = await picker.pickMultiImage();

  //     _selectedImages.addAll(images);
  //     if (_selectedImages.isNotEmpty) {
  //       for (XFile i in _selectedImages) {
  //         var image = await i.readAsBytes();
  //         _storeImages.add(image);
  //       }
  //       adapter.storeImage(_storeImages);

  //       getImageFromDatabase();
  //       clearMultipleImages();
  //       log("${_storeImages.length}   success bruh ");
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }

  //   notifyListeners();
  // }

  saveImagesInFiles() async {
    _selectedImages = [];
    try {
      Directory? dir = await getExternalStorageDirectory();
      Box box = await Hive.openBox<String>('new-box');
      log(dir!.path.toString());
      String filename = 'images';
      final imagesPath = Directory('${dir.path}/$filename');
      bool a = await imagesPath.exists();
      log(imagesPath.path.toString());
      if (a) {
        final ImagePicker picker = ImagePicker();
        List<XFile>? images = await picker.pickMultiImage();
        _selectedImages.addAll(images);
        if (_selectedImages.isNotEmpty) {
          for (XFile i in _selectedImages) {
            Uint8List image = await i.readAsBytes();
            var g = RandomStringGenerator(fixedLength: 5);
            String h = g.generate();
            File saveImage = File('${imagesPath.path}/$h');
            log(h);
            saveImage.writeAsBytes(image);
            box.add(saveImage.path);
          }
        }
      } else {
        log("creating now ");
        imagesPath.create();
      }
      _imagePaths = box.values.toList();
      log('${_imagePaths.length}this is the log');
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  // saveImagesInHiveDb() async {
  //   final ImagePicker picker = ImagePicker();
  //   try {
  //     List<XFile>? images = await picker.pickMultiImage();
  //     Box<ImageModel> box = await Hive.openBox<ImageModel>(pickHiveBox);
  //     _selectedImages.addAll(images);
  //     if (_selectedImages.isNotEmpty) {
  //       for (XFile i in _selectedImages) {
  //         var image = await i.readAsBytes();
  //         //  _storeImages = [..._storeImages, image];
  //         box.add(ImageModel(images: image));
  //       }
  //       log(_selectedImages.length.toString());

  //       _images = box.values.toList();
  //       log("added to hive db");
  //       //box.close();

  //       notifyListeners();
  //       clearMultipleImages();
  //       //log("${_storeImages.length}   success bruh ");
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // getImageshive() async {
  //   try {
  //     log("started");
  //     //final imageBox = Hive.box<ImageModel>('pics');
  //     Box<ImageModel> box = await Hive.openBox<ImageModel>(pickHiveBox);
  //     _images = box.values.toList();
  //     //box.close();

  //     //log(_list.iterator.current.images.length.toString());
  //     log("ended");
  //     notifyListeners();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // removeImageFromHive(int img) async {
  //   Box<ImageModel> box = await Hive.openBox<ImageModel>(pickHiveBox);
  //   await box.deleteAt(img);
  //   _images = box.values.toList();
  //   // box.close();
  //   notifyListeners();
  // }

  // getImagesFromHive() async {
  //   _hiveImages = [];
  //   final box = Boxes.getImageModel();
  //   final pics = Hive.box<ImageModel>('pics').values;
  //   _hiveImages.addAll(pics);
  //   log(_hiveImages.length.toString());
  //   notifyListeners();
  // }

  // getImageFromDatabase() async {
  //   try {
  //     _getImages = [];
  //     log("started");
  //     var images = await adapter.getImages();
  //     _getImages.addAll(images);
  //     log("completed");
  //     notifyListeners();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }
}
