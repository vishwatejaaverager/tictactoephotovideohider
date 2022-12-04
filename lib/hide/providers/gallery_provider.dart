import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project_first/boxes.dart';
import 'package:my_project_first/main.dart';
import 'package:my_project_first/model/image/image_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:share_plus/share_plus.dart';

class GalleryProvider with ChangeNotifier {
  //final List<XFile> _sharableImages = [];

  final imageBox = Boxes.getImageModelBox();

  final bool _isSharing = false;
  bool get isSharing => _isSharing;

  bool _isFavImage = false;
  bool get isFavImage => _isFavImage;

  List<ImageModel> _imagePaths = [];
  List<ImageModel> get imagePaths => _imagePaths;

  // List<ImageModel> _favImagePaths = [];
  // List<ImageModel> get favImagePaths => _favImagePaths;

  final String _favHiveBox = 'fav-path-box';
  String get favHiveBox => _favHiveBox;

  final String _pickHiveBox = 'image-path-box';
  String get pickHiveBox => _pickHiveBox;

  final String _fileName = 'voila';
  String get fileName => _fileName;

  List<XFile> _selectedImages = [];
  List<XFile>? get selectedImages => _selectedImages;

  List<int> _multiSelect = [];
  List<int> get multiSelect => _multiSelect;

  int? _currentImage;
  int? get currentImage => _currentImage;

  int? _favCurrentImage;
  int? get favCurrentImage => _favCurrentImage;

  bool _isSelecting = false;
  bool get isSelecting => _isSelecting;

  bool _isDeleting = false;
  bool get isDeleting => _isDeleting;

  setMultiselect(List<int> b) {
    _multiSelect = b;
    log(_multiSelect.toString());
    //notifyListeners();
  }

  setIsSelecting(bool a) {
    _isSelecting = a;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

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

  
  shareMultiple(List<int> a) async {
    try {
      log("came ");
      List<XFile> share = [];
      for (var i in a) {
        final directory = await getTemporaryDirectory();
        String path = directory.path;
        var a = imageBox.getAt(i)!.imagePath;
        File file = File(a);
        Uint8List b = await file.readAsBytes();
        File c = await File(file.path).writeAsBytes(b);
        var g = RandomStringGenerator(fixedLength: 5);
        String h = g.generate();
        final File newim = await c.copy('$path/$h.jpg');
        XFile files = XFile(newim.path);
        share.add(files);
      }
      await Share.shareXFiles(share);
    } catch (e) {
      log(e.toString());
    }
  }

  

  deleteMultipleImages(List<int> a) async {
    try {
      _isDeleting = true;
      log("came");
      for (var b in a) {
        var c = imageBox.getAt(b);
        File file = File(c!.imagePath);
        await file.delete().whenComplete(() {
          _isDeleting = false;
          SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {
            notifyListeners();
          });
        });
        imageBox.deleteAt(b);
      }
      // getImagesFromFile();
    } catch (e) {
      log(e.toString());
    }
  }

  deleteImage(
    File file,
  ) async {
    try {
      var a = await file.delete();
      if (!await a.exists()) {
        for (final e in imageBox.keys) {
          if (imageBox.get(e)!.imagePath == file.path) {
            imageBox.delete(e);
          }
        }
      }
      // if (!await a.exists()) {
      //   Box box = await Hive.openBox<String>(pickHiveBox);
      //   Box favBox = await Hive.openBox<String>(favHiveBox);

      //   for (final key in box.keys) {
      //     if (box.get(key) == file.path) {
      //       box.delete(key);
      //     }
      //   }
      //   for (final key in favBox.keys) {
      //     if (box.get(key) == file.path) {
      //       favBox.delete(key);
      //     }
      //   }
      // for (var element in favBox.values) {
      //   var i = 0;
      //   i++;
      //   if (element == file.path) {
      //     favBox.deleteAt(i - 1);
      //     _isFavImage = false;
      //     log("deleted at fav");
      //     getFavImagesFromFile();
      //   }
      // }
      // getImagesFromFile();
      log("deleted from hive");
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

  // addImagetoFav(String path) async {
  //   await checkIfExistsInFav(path);
  //   Box box = await Hive.openBox<String>(favHiveBox);
  //   if (!_isFavImage) {
  //     box.add(path);
  //     _favImagePaths = box.values.toList();
  //     log("added to fav");
  //     _isFavImage = true;
  //   } else {
  //     for (var element in box.values) {
  //       var i = 0;
  //       i++;
  //       if (element == path) {
  //         box.deleteAt(i - 1);
  //         _isFavImage = false;
  //         log("deleted at fav");
  //       }
  //     }
  //   }
  //   log(_isFavImage.toString());
  //   notifyListeners();
  //   //var a = box.values.firstWhere((element) => element == path);
  //   // log(a.toString());
  // }

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
      //Box box = await Hive.openBox<String>(pickHiveBox); //hive box
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
            ImageModel imageModel = ImageModel(imagePath: saveImage.path);
            imageBox.add(imageModel);
          }
        }
      } else {
        log("creating now ");
        imagesPath.create();
      }
      //getImagesFromFile();
      log('${_imagePaths.length}this is the log');

      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  // getImagesFromFile() async {
  //   //Box box = await Hive.openBox<String>(pickHiveBox);
  //   _imagePaths = imageBox.values.toList();
  //   notifyListeners();
  //   //hive box
  // }

  // getFavImagesFromFile() async {
  //   log("called fav");
  //   for (var e in imageBox.values) {
  //     bool a = e.isFav;
  //     if (a) {
  //       _favImagePaths.add(e);
  //     } else {
  //       _favImagePaths.remove(e);
  //     }
  //   }
  //   notifyListeners();
  // }

  addFav(String path) {
    for (var e in imageBox.keys) {
      if (imageBox.get(e)!.imagePath == path) {
        ImageModel imageModel = ImageModel(imagePath: path, isFav: true);
        imageBox.put(e, imageModel);
        // _favImagePaths.add(imageModel);
        // log(_favImagePaths.length.toString());
        log("added in fav");
        notifyListeners();
      }
    }
  }

  removeFav(String path) {
    for (var e in imageBox.keys) {
      if (imageBox.get(e)!.imagePath == path) {
        ImageModel imageModel = ImageModel(imagePath: path, isFav: false);
        imageBox.put(e, imageModel);
        // var a = _favImagePaths.every(
        //   (element) {
        //     return element == imageModel;
        //   },
        // );
        //log(a.toString());
        // log(_favImagePaths.length.toString());
        notifyListeners();
        log("removed in fav");
      }
    }
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
