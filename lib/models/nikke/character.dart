class Character extends Object {
  String name;
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

  int activeSkinIndex = 0;

  Skin get activeSkin => skins[activeSkinIndex];
}

class Skin extends Object {
  final String code;
  String name;
  final String avatar;
  final String spine;
  final List<Action> actions;
  bool enable;

  Skin({
    required this.code,
    required this.name,
    required this.avatar,
    required this.spine,
    required this.actions,
    this.enable = true,
  });

  Skin.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String,
        name = json['name'] as String,
        avatar = json['avatar'] as String,
        spine = json['spine'] as String,
        actions = (json['actions'] as List<dynamic>)
            .map((e) => Action.fromJson(e as Map<String, dynamic>))
            .toList(),
        enable = json['enable'] ?? true;

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'avatar': avatar,
        'spine': spine,
        'actions': actions.map((e) => e.toJson()).toList(),
        'enable': enable,
      };

  @override
  String toString() => toJson().toString();

  int activeActionIndex = 0;

  Action get activeAction => actions[activeActionIndex];
}

class Action extends Object {
  final String name;
  final String skel;
  final String atlas;
  final String animation;
  final List<String>? notLoopAnimations;

  Action({
    required this.name,
    required this.skel,
    required this.atlas,
    required this.animation,
    this.notLoopAnimations,
  });

  Action.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        skel = json['skel'] as String,
        atlas = json['atlas'] as String,
        animation = json['animation'] as String,
        notLoopAnimations =
            ((json['not_loop_animations'] as List<dynamic>?) ?? [])
                .map((e) => e as String)
                .toList();

  Map<String, dynamic> toJson() => {
        "name": name,
        "skel": skel,
        "atlas": atlas,
        "animation": animation,
        "not_loop_animations": notLoopAnimations,
      };

  bool shouldLoop(String animation) {
    if (notLoopAnimations == null) return true;
    if (notLoopAnimations!.isEmpty) return true;
    if (notLoopAnimations!.indexWhere((element) => element == animation) ==
        -1) {
      return true;
    }
    return false;
  }

  @override
  String toString() => toJson().toString();
}
