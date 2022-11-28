import 'dart:collection';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project_first/model/image_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart';

class GalleryProvider with ChangeNotifier {
  //final List<XFile> _sharableImages = [];

  bool _isSharing = false;
  bool get isSharing => _isSharing;

  List<ImageModel> _images = [];
  UnmodifiableListView<ImageModel> get images => UnmodifiableListView(_images);

  final String _pickHiveBox = 'image-box';
  String get pickHiveBox => _pickHiveBox;

  final List<XFile> _selectedImages = [];
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

  shareImage(Uint8List image) async {
    try {
      _isSharing = true;
      log('$_isSharing is sharing');
      Box<ImageModel> box = await Hive.openBox<ImageModel>(pickHiveBox);
      final directory = await getApplicationDocumentsDirectory();
      String path = directory.path;
      File a = await File(box.path!).writeAsBytes(image);
      var g = RandomStringGenerator(fixedLength: 5);
      String h = g.generate();
      final File newim = await a.copy('$path/$h.jpg');
      log(newim.toString());
      XFile file = XFile(newim.path);
      await Share.shareXFiles([file]);
      _isSharing = false;
      log('$_isSharing is sharing');
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

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

  saveImagesInHiveDb() async {
    final ImagePicker picker = ImagePicker();
    try {
      List<XFile>? images = await picker.pickMultiImage();
      Box<ImageModel> box = await Hive.openBox<ImageModel>(pickHiveBox);
      _selectedImages.addAll(images);
      if (_selectedImages.isNotEmpty) {
        for (XFile i in _selectedImages) {
          var image = await i.readAsBytes();
          //  _storeImages = [..._storeImages, image];
          box.add(ImageModel(images: image));
        }
        log(_selectedImages.length.toString());

        _images = box.values.toList();
        log("added to hive db");
        box.close();

        notifyListeners();
        clearMultipleImages();
        //log("${_storeImages.length}   success bruh ");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getImageshive() async {
    try {
      log("started");
      //final imageBox = Hive.box<ImageModel>('pics');
      Box<ImageModel> box = await Hive.openBox<ImageModel>(pickHiveBox);
      _images = box.values.toList();
      box.close();

      //log(_list.iterator.current.images.length.toString());
      log("ended");
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  removeImageFromHive(int img) async {
    Box<ImageModel> box = await Hive.openBox<ImageModel>(pickHiveBox);
    await box.deleteAt(img);
    _images = box.values.toList();
    box.close();
    notifyListeners();
  }

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
