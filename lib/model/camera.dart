import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'camera.g.dart';

@HiveType(typeId: 0)
class Camera extends HiveObject{
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  String? imageUrl;


  Camera({
    required this.title,
    required this.description,
    required this.imageUrl,
   
  });

  get index => null;


}
