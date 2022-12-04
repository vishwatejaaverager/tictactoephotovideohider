import 'package:hive/hive.dart';
part 'image_model.g.dart';

@HiveType(typeId: 0)
class ImageModel extends HiveObject {
  @HiveField(1)
  final String imagePath;

  @HiveField(2)
  final bool isFav;
  ImageModel({required this.imagePath,this.isFav = false});
}
