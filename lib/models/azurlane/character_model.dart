import 'package:live2d_viewer/constants/azurlane.dart';
import 'package:live2d_viewer/enum/ship_rarity.dart';
import 'package:live2d_viewer/enum/ship_type.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/models/base_model.dart';

class CharacterModel extends BaseModel {
  final String code;
  final String name;
  final String avatar;
  final int type;
  final int rarity;
  final int nationality;
  late final List<SkinModel> skins;

  CharacterModel({
    required this.code,
    required this.name,
    required this.avatar,
    required this.type,
    required this.rarity,
    required this.nationality,
    required this.skins,
  });

  CharacterModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String,
        name = json['name'] as String,
        avatar = json['avatar'] as String,
        type = json['type'] as int,
        rarity = json['rarity'] as int,
        nationality = json['nationality'] as int {
    skins = (json['skins'] as List<dynamic>).map((item) {
      return SkinModel.fromJson(item as Map<String, dynamic>)..character = this;
    }).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'avatar': avatar,
      'type': type,
      'rarity': rarity,
      'nationality': nationality,
    };
  }

  String get rarityLabel => AzurlaneConstants.rarityLabels[rarity] as String;

  String get avatarURL => '${AzurlaneConstants.characterAvatarURL}/$avatar';

  ShipRarity get shipRarity {
    int value = 0;
    if (nationality == 97) {
      value += 10;
    }
    if (code.endsWith('_g')) {
      value += rarity + 1;
    } else {
      value += rarity;
    }
    return AzurlaneConstants.raritys[value] ?? ShipRarity.rarity2;
  }

  ShipType get shipType {
    for (final item in ShipType.values) {
      if (item.value == type) {
        return item;
      }
    }
    return ShipType.type1;
  }

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
    int result = character.shipRarity.compareTo(shipRarity);
    result = result == 0 ? character.shipType.compareTo(shipType) : result;
    result = result == 0 ? code.compareTo(character.code) : result;
    return result;
  }
}
