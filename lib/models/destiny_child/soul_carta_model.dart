import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/services/destiny_child_service.dart';

class SoulCartaModel extends BaseModel {
  final String name;
  final String avatar;
  final String image;
  final bool useLive2d;
  final String? live2d;
  final bool enable;

  SoulCartaModel({
    required this.name,
    required this.avatar,
    required this.image,
    this.useLive2d = false,
    this.live2d,
    this.enable = true,
  });

  SoulCartaModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        avatar = json['avatar'] as String,
        image = json['image'] as String,
        useLive2d = json['use_live2d'] as bool? ?? false,
        live2d = json['live2d'] as String?,
        enable = json['enable'] as bool? ?? true;

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
      'image': image,
      if (useLive2d) ...{
        'use_live2d': useLive2d,
        'live2d': live2d,
      },
      if (!enable) 'enable': enable,
    };
  }

  String get avatarURL => '${DestinyChildConstants.soulCartaAvatarURL}/$avatar';

  String get imageURL => '${DestinyChildConstants.soulCartaImageURL}/$image';

  String? get live2dURL => live2d != null
      ? '${DestinyChildConstants.soulCartaLive2DURL}/$live2d'
      : null;

  String? get modelURL => live2dURL != null
      ? '$live2dURL/${DestinyChildService().getModelJSON(live2d!)}'
      : null;
}
