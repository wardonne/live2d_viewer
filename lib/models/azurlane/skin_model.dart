import 'package:live2d_viewer/constants/azurlane.dart';
import 'package:live2d_viewer/enum/ship_rarity.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/models/base_model.dart';

class SkinModel extends BaseModel {
  final String code;
  final String name;
  final String avatar;
  final String painting;
  late final List<String>? faces;
  late final String? faceRect;
  late final String? live2d;
  late final SpineModel? spine;
  final String? spinePainting;

  late final CharacterModel character;

  List<MotionModel> motions = [];

  SkinModel({
    required this.code,
    required this.name,
    required this.avatar,
    required this.painting,
    this.faces,
    this.faceRect,
    this.live2d,
    this.spine,
    this.spinePainting,
    required this.character,
  });

  SkinModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String,
        name = json['name'] as String,
        avatar = json['avatar'] as String,
        painting = json['painting'] as String,
        faceRect = json['face_rect'] as String?,
        live2d = json['live2d'] as String?,
        spinePainting = json['spine_painting'] as String? {
    spine = (json['spine'] as Map<String, dynamic>?) == null
        ? null
        : (SpineModel.fromJson(json['spine'] as Map<String, dynamic>)
          ..skin = this);
    faces = (json['faces'] as List<dynamic>?)?.map((e) => e as String).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code': code,
      'name': name,
      'avatar': avatar,
      'painting': painting,
      if (faces != null) 'faces': faces,
      if (faceRect != null) 'face_rect': faceRect,
      if (live2d != null) 'live2d': live2d,
      if (spine != null) 'spine': spine,
    };
  }

  bool get hasLive2d => live2d != null;

  bool get hasSpinePainting => spinePainting != null;

  String get avatarURL => '${AzurlaneConstants.characterAvatarURL}/$avatar';

  String get paintingURL =>
      '${AzurlaneConstants.characterPaintingURL}/$painting';

  String get faceRectURL => faceRect == null
      ? ''
      : '${AzurlaneConstants.characterFaceRectURL}/$faceRect';

  String faceURL(int index) => faces == null
      ? ''
      : '${AzurlaneConstants.characterPaintingFaceURL}/${faces![index]}';

  String get live2dURL =>
      live2d == null ? '' : '${AzurlaneConstants.characterLive2DURL}/$live2d';

  String get spineURL =>
      spine == null ? '' : '${AzurlaneConstants.characterSpineURL}/$spine';

  ShipRarity get shipRarity {
    int value = 0;
    if (character.nationality == 97) {
      value += 10;
    }
    if (code.endsWith('_g')) {
      value += character.rarity + 1;
    } else {
      value += character.rarity;
    }
    return AzurlaneConstants.raritys[value] ?? ShipRarity.rarity2;
  }

  bool enableFace = false;

  int activeFaceIndex = 0;

  String get activeFaceURL => enableFace ? faceURL(activeFaceIndex) : '';

  String get spinePaintingURL => spinePainting != null
      ? '${AzurlaneConstants.characterSpinePaintingURL}/$spinePainting'
      : '';
}
