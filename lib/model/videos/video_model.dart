import 'package:hive/hive.dart';
part 'video_model.g.dart';

@HiveType(typeId: 1)
class VideoModel extends HiveObject {
  @HiveField(2)
  final String videoPicPath;

  @HiveField(3)
  final String videoPath;

  @HiveField(4)
  final bool isFavVid;

  VideoModel({this.isFavVid = false,required this.videoPath,required this.videoPicPath});
}
