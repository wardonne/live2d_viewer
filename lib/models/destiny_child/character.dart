class Character extends Object {
  final String name;
  String avatar;
  final List<Skin> skins;
  bool enable;

  Character({
    required this.name,
    required this.avatar,
    required this.skins,
    this.enable = true,
  });

  Character.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        avatar = json['avatar'],
        skins = (json['skins'] as List<dynamic>)
            .map((e) => Skin.fromJson(e as Map<String, dynamic>))
            .toList(),
        enable = json['enable'] ?? true;

  Map<String, dynamic> toJson() => {
        'name': name,
        'avatar': avatar,
        'enable': enable,
        'skins': skins.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() => toJson().toString();
}

class Skin extends Object {
  final String code;
  final String name;
  final String description;
  final String avatar;
  final String live2d;
  bool enable;

  List<Expression>? expressions;
  List<Motion>? motions;

  Skin({
    required this.code,
    required this.name,
    required this.description,
    required this.avatar,
    required this.live2d,
    this.enable = true,
  });

  Skin.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String,
        name = json['name'] as String,
        description = json['description'] as String,
        avatar = json['avatar'] as String,
        live2d = json['live2d'] as String,
        enable = json['enable'] ?? true;

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'description': description,
        'avatar': avatar,
        'live2d': live2d,
        'enable': enable,
      };

  @override
  String toString() => toJson().toString();
}

class Expression extends Object {
  final String name;
  final String file;

  Expression({required this.name, required this.file});
}

class Motion extends Object {
  final String name;

  Motion({required this.name});
}
