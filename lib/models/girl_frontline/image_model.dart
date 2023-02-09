import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/base_model.dart';

class ImageModel extends BaseModel {
  final String normal;
  final String destroy;

  ImageModel({
    required this.normal,
    required this.destroy,
  });

  ImageModel.fromJson(Map<String, dynamic> json)
      : normal = json['normal'] as String,
        destroy = json['destroy'] as String;

  @override
  Map<String, dynamic> toJson() {
    return {
      'normal': normal,
      'destroy': destroy,
    };
  }

  String get normalImage =>
      '${GirlFrontlineConstants.characterImageURL}/$normal';

  String get destroyImage =>
      '${GirlFrontlineConstants.characterImageURL}/$destroy';
}
