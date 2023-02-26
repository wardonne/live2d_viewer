import 'package:live2d_viewer/models/base_model.dart';

class FaceRectModel extends BaseModel {
  late final List<double> anchor;
  late final List<double> position;
  late final List<double> size;
  late final List<double> pivot;

  FaceRectModel({
    required this.anchor,
    required this.position,
    required this.size,
    required this.pivot,
  });

  FaceRectModel.fromJson(Map<String, dynamic> json) {
    anchor = (json['anchor'] as List<dynamic>).map((e) {
      return double.parse(e as String);
    }).toList();
    position = (json['position'] as List<dynamic>).map((e) {
      return double.parse(e as String);
    }).toList();
    size = (json['size'] as List<dynamic>).map((e) {
      return double.parse(e as String);
    }).toList();
    pivot = (json['pivot'] as List<dynamic>).map((e) {
      return double.parse(e as String);
    }).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, List<double>>{
      'anchor': anchor,
      'position': position,
      'size': size,
      'pivot': pivot,
    };
  }
}
