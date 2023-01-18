import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/utils/hash_util.dart';

class SoulCarta extends Object {
  final String image;
  final bool useLive2d;
  final String avatar;
  final String? live2d;
  String? name;
  bool enable;

  late String cachePath;

  SoulCarta({
    required this.image,
    required this.useLive2d,
    required this.avatar,
    this.live2d,
    this.name,
    this.enable = true,
  }) : cachePath =
            '${DestinyChildConstants.resourceCachePath}/${HashUtil().hashMd5('soul_carta')}/${HashUtil().hashMd5(image)}';

  SoulCarta.fromJson(Map<String, dynamic> json)
      : image = json['image'] as String,
        useLive2d = json['use_live2d'] as bool? ?? false,
        avatar = json['avatar'] as String,
        live2d = json['live2d'] as String? ?? '',
        name = json['name'] as String? ?? '',
        enable = json['enable'] as bool? ?? true {
    cachePath =
        '${DestinyChildConstants.resourceCachePath}/${HashUtil().hashMd5('soul_carta')}/${HashUtil().hashMd5(image)}';
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'image': image,
        'use_live2d': useLive2d,
        'avatar': avatar,
        'live2d': live2d,
        'name': name,
        'enable': enable,
      };

  @override
  String toString() => toJson().toString();

  String get avatarURL => '${DestinyChildConstants.soulCartaAvatarURL}/$avatar';

  String get imageURL => '${DestinyChildConstants.soulCartaImageURL}/$image';
}
