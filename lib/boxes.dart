import 'package:hive/hive.dart';
import 'package:my_project_first/model/image/image_model.dart';
import 'package:my_project_first/model/videos/video_model.dart';

class Boxes {
  static Box<String> get getFavs => Hive.box<String>('fav-path-box');
  static Box<ImageModel> getImageModelBox() =>
      Hive.box<ImageModel>('images-path-box');
  static Box<VideoModel> getVideoModelBox() =>
      Hive.box<VideoModel>('videos-path-box');
  //static Box<String> get getVidFavs => Hive.box<String>('fav-thumb-box');
}
