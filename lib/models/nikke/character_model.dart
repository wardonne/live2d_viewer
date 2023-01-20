import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/nikke/action_model.dart';
import 'package:live2d_viewer/models/nikke/skin_model.dart';

class CharacterModel extends BaseModel {
  final String name;
  final String avatar;
  final bool enable;

  late final List<SkinModel> skins;

  CharacterModel({
    required this.name,
    required this.avatar,
    this.enable = true,
    required this.skins,
  });

  CharacterModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        avatar = json['avatar'] as String,
        enable = json['enable'] as bool? ?? true {
    skins = (json['skins'] as List<dynamic>).map((skin) {
      return SkinModel.fromJson(skin as Map<String, dynamic>)..character = this;
    }).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatar': avatar,
      'skins': skins.map((e) => e.toJson()).toList(),
      if (!enable) 'enable': enable,
    };
  }

  String get avatarURL => '${NikkeConstants.characterAvatarURL}/$avatar';

  int activeSkinIndex = 0;

  SkinModel get activeSkin => skins[activeSkinIndex];

  switchSkin(SkinModel skin) {
    if (skin != activeSkin) {
      activeSkinIndex = skins.indexOf(skin);
      activeSkin.reset();
    }
  }

  ActionModel get activeAction => activeSkin.activeAction;

  switchAction(ActionModel action) {
    activeSkin.switchAction(action);
  }

  reset() {
    activeSkinIndex = 0;
    for (var element in skins) {
      element.reset();
    }
  }
}
