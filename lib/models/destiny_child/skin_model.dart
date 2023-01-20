import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/destiny_child/character_model.dart';
import 'package:live2d_viewer/models/destiny_child/expression_model.dart';
import 'package:live2d_viewer/models/destiny_child/motion_model.dart';
import 'package:live2d_viewer/services/destiny_child_service.dart';

class SkinModel extends BaseModel {
  final String code;
  final String name;
  final String description;
  final String avatar;
  final String live2d;
  final bool enable;

  late final CharacterModel character;

  List<ExpressionModel> expressions = [];

  List<MotionModel> motions = [];

  SkinModel({
    required this.code,
    required this.name,
    required this.description,
    required this.avatar,
    required this.live2d,
    this.enable = true,
  });

  SkinModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String? ?? '',
        name = json['name'] as String? ?? '',
        description = json['description'] as String? ?? '',
        avatar = json['avatar'] as String? ?? '',
        live2d = json['live2d'] as String,
        enable = json['enable'] as bool? ?? true;

  @override
  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'description': description,
        'avatar': avatar,
        'live2d': live2d,
        if (!enable) 'enable': enable,
      };

  @override
  String toString() => toJson().toString();

  String get avatarURL => '${DestinyChildConstants.characterAvatarURL}/$avatar';

  String get live2dURL => '${DestinyChildConstants.characterLive2DURL}/$code';

  String get modelURL =>
      '$live2dURL/${DestinyChildService().getModelJSON(code)}';
}
