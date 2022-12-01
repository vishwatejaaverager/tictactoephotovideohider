import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:share_plus/share_plus.dart';

class GalleryProvider with ChangeNotifier {
  //final List<XFile> _sharableImages = [];

  final bool _isSharing = false;
  bool get isSharing => _isSharing;

  bool _isFavImage = false;
  bool get isFavImage => _isFavImage;

  List<dynamic> _imagePaths = [];
  List<dynamic> get imagePaths => _imagePaths;

  List<dynamic> _favImagePaths = [];
  List<dynamic> get favImagePaths => _favImagePaths;

  final String _favHiveBox = 'fav-path-box';
  String get favHiveBox => _favHiveBox;

  final String _pickHiveBox = 'image-path-box';
  String get pickHiveBox => _pickHiveBox;

  final String _fileName = 'voila';
  String get fileName => _fileName;

  List<XFile> _selectedImages = [];
  List<XFile>? get selectedImages => _selectedImages;

  int? _currentImage;
  int? get currentImage => _currentImage;

  int? _favCurrentImage;
  int? get favCurrentImage => _favCurrentImage;

  setCurrentImage(int s) {
    _currentImage = s;
    _favCurrentImage = s;
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

  shareImage(File file) async {
    try {
      final directory = await getTemporaryDirectory();
      String path = directory.path;
      log('$path this is the path');
      Uint8List b = await file.readAsBytes();
      File c = await File(file.path).writeAsBytes(b);
      var g = RandomStringGenerator(fixedLength: 5);
      String h = g.generate();
      final File newim = await c.copy('$path/$h.jpg');
      XFile files = XFile(newim.path);
      await Share.shareXFiles([files]);
    } catch (e) {
      log(e.toString());
    }
  }

  deleteImage(File file,) async {
    try {
      var a = await file.delete();
      if (!await a.exists()) {
        Box box = await Hive.openBox<String>(pickHiveBox);
        Box favBox = await Hive.openBox<String>(favHiveBox);
        for (var element in box.values) {
          var i = 0;
          i++;
          if (element == file.path) {
            box.deleteAt(i - 1);
          }
        }
        for (var element in favBox.values) {
          var i = 0;
          i++;
          if (element == file.path) {
            favBox.deleteAt(i - 1);
            _isFavImage = false;
            log("deleted at fav");
            getFavImagesFromFile();
          }
        }
        getImagesFromFile();
        log("deleted from hive");
      }
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

  addImagetoFav(String path) async {
    await checkIfExistsInFav(path);
    Box box = await Hive.openBox<String>(favHiveBox);
    if (!_isFavImage) {
      box.add(path);
      _favImagePaths = box.values.toList();
      log("added to fav");
      _isFavImage = true;
    } else {
      for (var element in box.values) {
        var i = 0;
        i++;
        if (element == path) {
          box.deleteAt(i - 1);
          _isFavImage = false;
          log("deleted at fav");
        }
      }
    }
    log(_isFavImage.toString());
    notifyListeners();
    //var a = box.values.firstWhere((element) => element == path);
    // log(a.toString());
  }

  // removeFromFav(int id, String path) async {
  //   await checkIfExistsInFav(path);
  //   Box box = await Hive.openBox<String>(favHiveBox);
  //   if (!_isFavImage) {
  //     box.deleteAt(id);
  //     _favImagePaths = box.values.toList();
  //     log("removed from fav");
  //     notifyListeners();
  //   } else {
  //     box.add(path);
  //     _favImagePaths = box.values.toList();
  //     log("added to fav ");
  //   }
  // }

  // Future<bool> check(String path) async {
  //   Box box = await Hive.openBox<String>(favHiveBox);
  //   bool a = box.values.contains(path);
  //   return a;
  // }

  checkIfExistsInFav(String path) async {
    Box box = await Hive.openBox<String>(favHiveBox);
    _isFavImage = box.values.contains(path);
    notifyListeners();
  }

  saveImagesInFiles() async {
    _selectedImages = [];
    try {
      //gets app dir

      Directory? dir = await getExternalStorageDirectory();
      Box box = await Hive.openBox<String>(pickHiveBox); //hive box
      log(dir!.path.toString());
      final imagesPath = Directory('${dir.path}/$_fileName');
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

  getImagesFromFile() async {
    Box box = await Hive.openBox<String>(pickHiveBox);
    _imagePaths = box.values.toList();
    notifyListeners();
    //hive box
  }

  getFavImagesFromFile() async {
    Box box = await Hive.openBox<String>(favHiveBox);
    _favImagePaths = box.values.toList();
    notifyListeners();
  }

  // Future<bool> requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

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
