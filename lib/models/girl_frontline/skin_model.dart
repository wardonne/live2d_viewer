import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/girl_frontline/avatar_model.dart';
import 'package:live2d_viewer/models/girl_frontline/character_model.dart';
import 'package:live2d_viewer/models/girl_frontline/image_model.dart';
import 'package:live2d_viewer/models/girl_frontline/live2d_model.dart';
import 'package:live2d_viewer/models/girl_frontline/motion_model.dart';
import 'package:live2d_viewer/models/girl_frontline/spine_model.dart';

class SkinModel extends BaseModel {
  final String code;
  final String name;
  final String? dialog;
  final String? note;
  final AvatarModel avatar;
  final ImageModel image;
  late final Map<String, SpineModel>? spine;
  late final Live2DModel? live2d;

  late final CharacterModel character;

  List<MotionModel> motions = [];

  SkinModel({
    required this.code,
    required this.name,
    this.dialog,
    this.note,
    required this.avatar,
    required this.image,
    this.spine,
    this.live2d,
    required this.character,
  });

  SkinModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String,
        name = json['name'] as String,
        dialog = json['dialog'] as String?,
        note = json['note'] as String?,
        avatar = AvatarModel.fromJson(json['avatar'] as Map<String, dynamic>),
        image = ImageModel.fromJson(json['image'] as Map<String, dynamic>) {
    live2d = (json['live2d'] as Map<String, dynamic>?) != null
        ? (Live2DModel.fromJson(json['live2d'] as Map<String, dynamic>)
          ..skin = this)
        : null;
    final spineJson = json['spine'] as Map<String, dynamic>?;
    spine = spineJson != null
        ? {
            if ((spineJson['normal'] as Map<String, dynamic>?) != null)
              'normal': SpineModel.fromJson(
                  spineJson['normal'] as Map<String, dynamic>)
                ..skin = this,
            if ((spineJson['rest'] as Map<String, dynamic>?) != null)
              'rest':
                  SpineModel.fromJson(spineJson['rest'] as Map<String, dynamic>)
                    ..skin = this,
          }
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      if (dialog != null) 'dialog': dialog,
      if (note != null) 'note': note,
      'avatar': avatar.toJson(),
      'image': image.toJson(),
      if (spine != null)
        'spine': spine!.map<String, Map<String, dynamic>>(
          (key, value) => MapEntry(key, value.toJson()),
        ),
      if (live2d != null) 'live2d': live2d!.toJson(),
    };
  }

  bool isDestoryMode = false;

  switchMode() {
    isDestoryMode = !isDestoryMode;
  }

  String get destroyAvatar => avatar.destroyAvatar;

  String get normalAvatar => avatar.normalAvatar;

  String get destroyImage => image.destroyImage;

  String get normalImage => image.normalImage;

  bool get hasLive2d => live2d != null;
}
