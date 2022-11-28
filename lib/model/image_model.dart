import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'image_model.g.dart';

@HiveType(typeId: 1)
class ImageModel {
  @HiveField(0)
  Uint8List images;

  ImageModel({required this.images});
}
