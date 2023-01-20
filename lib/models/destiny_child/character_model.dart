import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/destiny_child/skin_model.dart';

class CharacterModel extends BaseModel {
  final String name;
  final String avatar;
  final bool enable;
  late final List<SkinModel> skins;
  late final SkinModel? spring;

  CharacterModel({
    required this.name,
    required this.avatar,
    this.enable = true,
    required this.skins,
    this.spring,
  });

  CharacterModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String? ?? '',
        avatar = json['avatar'] as String? ?? '',
        enable = json['enable'] as bool? ?? true {
    skins = (json['skins'] as List<dynamic>).map((skin) {
      return SkinModel.fromJson(skin as Map<String, dynamic>)..character = this;
    }).toList();
    spring = json['spring'] != null
        ? (SkinModel.fromJson(json['spring'] as Map<String, dynamic>)
          ..character = this)
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
      'skins': skins.map((skin) => skin.toJson()).toList(),
      if (spring != null) 'spring': spring!.toJson(),
      if (!enable) 'enable': enable,
    };
  }

  String get avatarURL => '${DestinyChildConstants.characterAvatarURL}/$avatar';

  late int activeSkinIndex = 0;

  SkinModel get activeSkin => skins[activeSkinIndex];

  switchSkin(SkinModel skin) {
    if (skin != activeSkin) {
      activeSkinIndex = skins.indexOf(skin);
    }
  }

  reset() {
    activeSkinIndex = 0;
  }
}
