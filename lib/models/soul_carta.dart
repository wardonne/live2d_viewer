import 'package:json_annotation/json_annotation.dart';
import 'package:live2d_viewer/constant/resources.dart';

part 'soul_carta.g.dart';

List<SoulCarta> loadSoulCarta(List<dynamic> list) {
  List<SoulCarta> result = [];
  for (var item in list) {
    result.add(SoulCarta.fromJson(item));
  }
  return result;
}

@JsonSerializable()
class SoulCarta extends Object {
  @JsonKey(name: 'image')
  String image;

  @JsonKey(name: 'use_live2d')
  bool useLive2d;

  @JsonKey(name: 'avatar')
  String avatar;

  SoulCarta(
    this.image,
    this.useLive2d,
    this.avatar,
  );

  factory SoulCarta.fromJson(Map<String, dynamic> srcJson) =>
      _$SoulCartaFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SoulCartaToJson(this);

  String get avatarPath {
    return '$dcSoulCartaAvatarPath/$avatar';
  }

  String get imagePath {
    return '$dcSoulCartaImagePath/$image';
  }
}
