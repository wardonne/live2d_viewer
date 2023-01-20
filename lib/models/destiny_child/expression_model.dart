import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/destiny_child/skin_model.dart';

class ExpressionModel extends BaseModel {
  final String name;
  final String file;

  late final SkinModel skin;

  ExpressionModel({
    required this.name,
    required this.file,
  });

  ExpressionModel.fromJson(Map<String, String> json)
      : name = json['name'] as String,
        file = json['file'] as String;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'file': file,
    };
  }

  String get url => '${skin.live2dURL}/$file';
}
