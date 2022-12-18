List<SoulCarta> loadSoulCarta(List<dynamic> list) {
  List<SoulCarta> result = [];
  for (var item in list) {
    result.add(SoulCarta.fromJson(item));
  }
  return result;
}

class SoulCarta extends Object {
  final String image;

  final bool useLive2d;

  final String avatar;

  final String? live2d;

  SoulCarta(
    this.image,
    this.useLive2d,
    this.avatar,
    this.live2d,
  );

  SoulCarta.fromJson(Map<String, dynamic> json)
      : image = json['image'],
        useLive2d = json['use_live2d'],
        avatar = json['avatar'],
        live2d = json['live2d'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'image': image,
        'use_live2d': useLive2d,
        'avatar': avatar,
        'live2d': live2d,
      };

  @override
  String toString() => toJson().toString();
}
