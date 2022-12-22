class SoulCarta extends Object {
  final String image;

  final bool useLive2d;

  final String avatar;

  final String? live2d;

  final String? name;

  SoulCarta(
    this.image,
    this.useLive2d,
    this.avatar,
    this.live2d,
    this.name,
  );

  SoulCarta.fromJson(Map<String, dynamic> json)
      : image = json['image'],
        useLive2d = json['use_live2d'],
        avatar = json['avatar'],
        live2d = json['live2d'],
        name = json['name'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'image': image,
        'use_live2d': useLive2d,
        'avatar': avatar,
        'live2d': live2d,
        'name': name,
      };

  @override
  String toString() => toJson().toString();
}
