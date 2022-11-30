import 'package:hive/hive.dart';

class Boxes{
  static Box<String> get getFavs=>Hive.box<String>('fav-path-box');
}