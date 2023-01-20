import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/nikke/action_model.dart';
import 'package:live2d_viewer/models/nikke/character_model.dart';

class SkinModel extends BaseModel {
  final String code;
  final String name;
  final String avatar;
  final String spine;
  final bool enable;

  late final List<ActionModel> actions;

  late final CharacterModel character;

  SkinModel({
    required this.code,
    required this.name,
    required this.avatar,
    required this.spine,
    this.enable = true,
    required this.actions,
  });

  SkinModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String,
        name = json['name'] as String,
        avatar = json['avatar'] as String,
        spine = json['spine'] as String,
        enable = json['enable'] as bool? ?? true {
    actions = (json['actions'] as List<dynamic>).map((action) {
      return ActionModel.fromJson(action as Map<String, dynamic>)..skin = this;
    }).toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'avatar': avatar,
      'spine': spine,
      'actions': actions.map((action) => action.toJson()).toList(),
      if (!enable) 'enable': enable,
    };
  }

  String get avatarURL => '${NikkeConstants.characterAvatarURL}/$avatar';

  String get spineURL => '${NikkeConstants.characterSpineURL}/$spine';

  int activeActionIndex = 0;

  ActionModel get activeAction => actions[activeActionIndex];

  switchAction(ActionModel action) {
    if (action != activeAction) {
      activeActionIndex = actions.indexOf(action);
    }
  }

  reset() {
    activeActionIndex = 0;
  }
}
