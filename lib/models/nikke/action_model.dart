import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/nikke/skin_model.dart';

class ActionModel extends BaseModel {
  final String name;
  final String skel;
  final String atlas;
  final String animation;
  final bool enable;

  late final SkinModel skin;

  ActionModel({
    required this.name,
    required this.skel,
    required this.atlas,
    required this.animation,
    this.enable = true,
  });

  ActionModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        skel = json['skel'] as String,
        atlas = json['atlas'] as String,
        animation = json['animation'] as String,
        enable = json['enable'] as bool? ?? true;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'skel': skel,
      'atlas': atlas,
      'animation': animation,
      if (!enable) 'enable': enable,
    };
  }

  String get prefix => name == 'default' ? '' : name;

  String get spineURL => [
        skin.spineURL,
        if (prefix.isNotEmpty) prefix,
      ].join('/');

  String get skelURL => '${skin.spineURL}/$skel';

  String get atlasURL => '${skin.spineURL}/$atlas';
}
