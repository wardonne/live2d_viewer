import 'package:live2d_viewer/constants/nikke.dart';
import 'package:path/path.dart' as p;

class NikkeSettings extends Object {
  CharacterSettings? characterSettings;

  NikkeSettings({
    this.characterSettings,
  });

  NikkeSettings.init() : characterSettings = CharacterSettings.init();

  NikkeSettings.fromJson(Map<String, dynamic>? json)
      : characterSettings = CharacterSettings.fromJson(json?['character']);

  Map<String, dynamic> toJson() => {
        "character": characterSettings?.toJson(),
      };

  @override
  String toString() => toJson().toString();
}

class CharacterSettings extends Object {
  String? virtualHost;
  String? path;
  String? dataPath;
  String? backups;

  CharacterSettings({
    this.virtualHost,
    this.path,
    this.dataPath,
    this.backups,
  });

  CharacterSettings.init()
      : virtualHost = NikkeConstants.defaultCharacterVirtualHost,
        path = NikkeConstants.defaultCharacterPath,
        dataPath = NikkeConstants.defaultCharacterDataPath,
        backups = NikkeConstants.defaultCharacterBackups;

  CharacterSettings.fromJson(Map<String, dynamic>? json)
      : virtualHost =
            json?['virtual_host'] ?? NikkeConstants.defaultCharacterVirtualHost,
        path = json?['path'] ?? NikkeConstants.defaultCharacterPath,
        dataPath =
            json?['data_path'] ?? NikkeConstants.defaultCharacterDataPath,
        backups =
            json?['backup_list'] ?? NikkeConstants.defaultCharacterBackups;

  Map<String, String?> toJson() => {
        'virtual_host': virtualHost,
        'path': path,
        'data_path': dataPath,
        'backup_list': backups,
      };

  @override
  String toString() => toJson().toString();

  String get avatarPath => p.join(path.toString(), 'avatars');

  String get spinePath => p.join(path.toString(), 'spine');

  String get spineHost => '$virtualHost/spine';
}
