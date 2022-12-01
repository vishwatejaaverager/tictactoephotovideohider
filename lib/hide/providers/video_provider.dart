import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string_generator/random_string_generator.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoProvider with ChangeNotifier {
  //actuall images of videos and videos
  List<dynamic> _videoThumbImage = [];
  List<dynamic> get videoThumbImage => _videoThumbImage;

  List<dynamic> _actualVids = [];
  List<dynamic> get actualVids => _actualVids;

  List<dynamic> _favVids = [];
  List<dynamic> get favVids => _favVids;

  List<dynamic> _favThub = [];
  List<dynamic> get favThumb => _favThub;

  //contains all the present picked videos
  List<File> _videoFiles = [];
  List<File> get videoFiles => _videoFiles;

  //vidos box names hive
  final String _thumbNailbox = 'thumb-box';
  String get thumbNailBox => _thumbNailbox;

  final String _videoPathbox = 'video-path-box';
  String get videoPathbox => _videoPathbox;

  final String _favPathbox = 'fav-path-box';
  String get favPathBox => _favPathbox;

  final String _favThumbBox = 'fav-thumb-box';
  String get favThumbBox => _favThumbBox;

  //file names in file manager
  final String _videoFileName = 'videos_images';
  String get videoFileName => _videoFileName;

  final String _videos = 'videos';
  String get videos => _videos;

  bool _isFavVid = false;
  bool get isFavVid => _isFavVid;

  // pickMultipleVideo() async {
  //   _videoFiles = [];
  //   try {
  //     // FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     //     type: FileType.custom,
  //     //     allowMultiple: true,
  //     //     allowedExtensions: ['mp4']);
  //     // List<File> files = result!.paths.map((path) => File(path!)).toList();
  //     // _videoFiles.addAll(files);

  //     notifyListeners();
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  deleteVideo(File file) async {
    try {
      var a = await file.delete();
      if (!await a.exists()) {
        //Box box = await Hive.openBox<String>(_favPathbox);
        Box vidthumbBox = await Hive.openBox<String>(_thumbNailbox);
       // Box thumbBox = await Hive.openBox<String>(_favThumbBox);
        Box vidBox = await Hive.openBox<String>(_videoPathbox);
        for (var element in vidBox.values) {
          var i = 0;
          i++;
          if (element == file.path) {
            vidBox.deleteAt(i - 1);
            vidthumbBox.deleteAt(i - 1);
          }
        }
        // for (var element in box.values) {
        //   var i = 0;
        //   i++;
        //   if (element == file.path) {
        //     box.deleteAt(i - 1);
        //     thumbBox.deleteAt(i - 1);
        //   }
        // }
        getVideoFilesFromHive();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // addVideoToFav(File file) async {
  //   await checkVideoInFav(file.path);
  //   try {
  //     Box box = await Hive.openBox<String>(_favPathbox);
  //     Box vidthumbBox = await Hive.openBox<String>(_thumbNailbox);
  //     Box thumbBox = await Hive.openBox<String>(_favThumbBox);
  //     Box vidBox = await Hive.openBox<String>(_videoPathbox);
  //     // Box favVidBox = await Hive.openBox<String>(_favPathbox);
  //     if (!_isFavVid) {
  //       for (var e in vidthumbBox.values) {
  //         if (e == file.path) {
  //           thumbBox.add(e);
  //         }
  //       }
  //       for (var e in vidBox.values) {
  //         if (e == file.path) {
  //           box.add(e);
  //         }
  //       }
  //       box.add(file.path);
  //       _favThub = thumbBox.values.toList();
  //       _favVids = box.values.toList();
  //     } else {
  //       for (var element in box.values) {
  //         var i = 0;
  //         i++;
  //         if (element == file.path) {
  //           box.deleteAt(i - 1);
  //           log("deleted to fav");
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   notifyListeners();
  // }

  checkVideoInFav(path) async {
    Box box = await Hive.openBox<String>(_favPathbox);
    _isFavVid = box.values.contains(path);
    notifyListeners();
  }

  storeThumnailsofVideos() async {
    _videoFiles = [];
    try {
      Directory? dir = await getExternalStorageDirectory();
      Box thumbBox = await Hive.openBox<String>(_thumbNailbox);
      Box videoBoxPath = await Hive.openBox<String>(_videoPathbox);
      log(dir!.path.toString());
      final videosImagesPath = Directory('${dir.path}/$_videoFileName');
      final videos = Directory('${dir.path}/$_videos');
      bool a = await videosImagesPath.exists();
      bool b = await videos.exists();
      if (a && b) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowMultiple: true,
            allowedExtensions: ['mp4']);
        List<File> files = result!.paths.map((path) => File(path!)).toList();
        _videoFiles.addAll(files);
        if (_videoFiles.isNotEmpty) {
          for (File i in _videoFiles) {
            Uint8List? videoImage = await VideoThumbnail.thumbnailData(
                video: i.path,
                imageFormat: ImageFormat.JPEG,
                maxWidth: 128,
                quality: 50);
            var g = RandomStringGenerator(fixedLength: 5);
            var f = RandomStringGenerator(fixedLength: 4);
            String h = g.generate();
            String t = f.generate();
            File saveVideo = File('${videos.path}/$t');
            File saveImage = File('${videosImagesPath.path}/$h');
            log(h);
            log(t);
            saveImage.writeAsBytes(videoImage!);
            i.copy(saveVideo.path);
            thumbBox.add(saveImage.path);
            videoBoxPath.add(saveVideo.path);
            log("${saveVideo.path} video path");
            log("${saveImage.path} image path");
            getVideoFilesFromHive();
          }
        }
      } else {
        log("creating now ");
        videosImagesPath.create();
        videos.create();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  getVideoFilesFromHive() async {
    log("called get vids");
    Box thumbBox = await Hive.openBox<String>(_thumbNailbox);
    Box videoBoxPath = await Hive.openBox<String>(_videoPathbox);
    _videoThumbImage = thumbBox.values.toList();
    _actualVids = videoBoxPath.values.toList();
    notifyListeners();
    log(_videoThumbImage.toString());
    log(_actualVids.toString());
  }

  getFavVidsFromHive() async {
    Box box = await Hive.openBox<String>(_favPathbox);
    _favVids = box.values.toList();
    notifyListeners();
  }
}
