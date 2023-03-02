import 'package:live2d_viewer/enum/gun_rank.dart';
import 'package:live2d_viewer/enum/gun_type.dart';
import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/girl_frontline/avatar_model.dart';
import 'package:live2d_viewer/models/girl_frontline/skin_model.dart';

class CharacterModel extends BaseModel {
  final String code;
  final String name;
  final int rank;
  final int type;
  final AvatarModel avatar;
  late final List<SkinModel> skins;
  CharacterModel({
    required this.code,
    required this.name,
    required this.rank,
    required this.type,
    required this.avatar,
    required this.skins,
  });

  CharacterModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String,
        name = json['name'] as String,
        rank = json['rank'] as int,
        type = json['type'] as int,
        avatar = AvatarModel.fromJson(json['avatar'] as Map<String, dynamic>) {
    skins = (json['skins'] as List<dynamic>)
        .map(
          (skin) => SkinModel.fromJson(skin as Map<String, dynamic>)
            ..character = this,
        )
        .toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'avatar': avatar.toJson(),
      'skins': skins.map((e) => e.toJson()),
    };
  }

  bool isDestoryMode = false;

  switchMode() {
    isDestoryMode = !isDestoryMode;
  }

  GunRank get gunRank {
    for (final item in GunRank.values) {
      if (item.value == rank) {
        return item;
      }
    }
    return GunRank.rank1;
  }

  GunType get gunType {
    for (final item in GunType.values) {
      if (item.value == type) {
        return item;
      }
    }
    return GunType.hg;
  }

  String get destroyAvatar => avatar.destroyAvatar;

  String get normalAvatar => avatar.normalAvatar;

  String get destroyImage => activeSkin.destroyImage;

  String get normalImage => activeSkin.normalImage;

  int activeSkinIndex = 0;

  SkinModel get activeSkin => skins[activeSkinIndex];

  void switchSkin(SkinModel skin) {
    if (skin != activeSkin) {
      activeSkinIndex = skins.indexOf(skin);
    }
  }

  void reset() {
    activeSkinIndex = 0;
  }

  int compareTo(CharacterModel character) {
    int result = character.rank.compareTo(rank);
    result = result == 0 ? character.type.compareTo(type) : result;
    result = result == 0 ? code.compareTo(character.code) : result;
    return result;
  }
}
