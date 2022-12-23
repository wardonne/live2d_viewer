class SoulCarta extends Object {
  final String image;
  final bool useLive2d;
  final String avatar;
  final String? live2d;
  String? name;
  bool enable;

  SoulCarta({
    required this.image,
    required this.useLive2d,
    required this.avatar,
    this.live2d,
    this.name,
    this.enable = true,
  });

  SoulCarta.fromJson(Map<String, dynamic> json)
      : image = json['image'],
        useLive2d = json['use_live2d'] ?? false,
        avatar = json['avatar'],
        live2d = json['live2d'] ?? '',
        name = json['name'] ?? '',
        enable = json['enable'] ?? true;

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
}
