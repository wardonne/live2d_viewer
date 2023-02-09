import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/base_model.dart';

class AvatarModel extends BaseModel {
  final String normal;
  final String destroy;
  AvatarModel({required this.normal, required this.destroy});

  AvatarModel.fromJson(Map<String, dynamic> json)
      : normal = json['normal'] as String,
        destroy = json['destroy'] as String;

  @override
  Map<String, dynamic> toJson() {
    return {
      'normal': normal,
      'destroy': destroy,
    };
  }

  String get normalAvatar =>
      '${GirlFrontlineConstants.characterAvatarURL}/$normal';

  String get destroyAvatar =>
      '${GirlFrontlineConstants.characterAvatarURL}/$destroy';
}
