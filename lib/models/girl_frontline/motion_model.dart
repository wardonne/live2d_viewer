import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/girl_frontline/skin_model.dart';

class MotionModel extends BaseModel {
  final String name;

  late final SkinModel skin;

  MotionModel(this.name, {required this.skin});

  @override
  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
