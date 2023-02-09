import 'dart:math';

import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/destiny_child/skin_model.dart';

class MotionModel extends BaseModel {
  final String name;
  late final List<String> files;

  late final SkinModel skin;

  MotionModel({
    required this.name,
    required this.files,
    required this.skin,
  });

  MotionModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String {
    files = (json['configs'] as List<dynamic>).map((config) {
      return config['file'] as String;
    }).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'files': files,
    };
  }

  String get fileURL =>
      '${skin.live2dURL}/${files[Random().nextInt(files.length)]}';
}
