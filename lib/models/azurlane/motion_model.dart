import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/models/base_model.dart';

class MotionModel extends BaseModel {
  final String name;

  final SkinModel skin;

  MotionModel({
    required this.name,
    required this.skin,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
