import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/girl_frontline/skin_model.dart';

class Live2DModel extends BaseModel {
  final String normal;
  final String destroy;

  late final SkinModel skin;

  Live2DModel({
    required this.normal,
    required this.destroy,
    required this.skin,
  });

  Live2DModel.fromJson(Map<String, dynamic> json)
      : normal = json['normal'] as String,
        destroy = json['destroy'] as String;

  @override
  Map<String, dynamic> toJson() {
    return {
      'normal': normal,
      'destroy': destroy,
    };
  }

  String get normalLive2D =>
      '${GirlFrontlineConstants.characterLive2DURL}/$normal';

  String get destroyLive2D =>
      '${GirlFrontlineConstants.characterLive2DURL}/$destroy';
}
