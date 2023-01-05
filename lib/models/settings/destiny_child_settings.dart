import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:path/path.dart' as p;

class DestinyChildSettings extends Object {
  String? live2dVersion;
  int? defaultHome;
  SoulCartaSettings? soulCartaSettings;
  CharacterSettings? characterSettings;

  DestinyChildSettings({
    this.live2dVersion,
    this.defaultHome,
    this.soulCartaSettings,
    this.characterSettings,
  });

  DestinyChildSettings.init()
      : live2dVersion = DestinyChildConstants.defaultLive2DVersion,
        defaultHome = DestinyChildConstants.defaultHome,
        soulCartaSettings = SoulCartaSettings.init(),
        characterSettings = CharacterSettings.init();

  DestinyChildSettings.fromJson(Map<String, dynamic>? json)
      : live2dVersion = json?['live2d_version'] ??
            DestinyChildConstants.defaultLive2DVersion,
        defaultHome =
            json?['default_home'] ?? DestinyChildConstants.defaultHome,
        soulCartaSettings = SoulCartaSettings.fromJson(json?['soul_carta']),
        characterSettings = CharacterSettings.fromJson(json?['character']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'live2d_version': live2dVersion,
        'default_home': defaultHome,
        'soul_carta': soulCartaSettings?.toJson(),
        'character': characterSettings?.toJson(),
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
      : virtualHost = DestinyChildConstants.defaultCharacterVirtualHost,
        path = DestinyChildConstants.defaultCharacterPath,
        dataPath = DestinyChildConstants.defaultCharacterDataPath,
        backups = DestinyChildConstants.defaultCharacterBackups;

  CharacterSettings.fromJson(Map<String, dynamic>? json)
      : virtualHost = json?['virtual_host'] ??
            DestinyChildConstants.defaultCharacterVirtualHost,
        path = json?['path'] ?? DestinyChildConstants.defaultCharacterPath,
        dataPath = json?['data_path'] ??
            DestinyChildConstants.defaultCharacterDataPath,
        backups = json?['backup_list'] ??
            DestinyChildConstants.defaultCharacterBackups;

  Map<String, String?> toJson() => <String, String?>{
        'virtual_host': virtualHost,
        'path': path,
        'data_path': dataPath,
        'backups': backups,
      };

  @override
  String toString() => toJson().toString();

  String get avatarPath => p.join(path.toString(), 'avatars');

  String get live2dPath => p.join(path.toString(), 'live2d');

  String get live2dHost => '$virtualHost/live2d';
}

class SoulCartaSettings extends Object {
  String? virtualHost;
  String? path;
  String? dataPath;
  String? backups;

  SoulCartaSettings({
    this.virtualHost,
    this.path,
    this.dataPath,
    this.backups,
  });

  SoulCartaSettings.init()
      : virtualHost = DestinyChildConstants.defaultSoulCartaVirtualHost,
        path = DestinyChildConstants.defaultSoulCartaPath,
        dataPath = DestinyChildConstants.defaultSoulCartaDataPath,
        backups = DestinyChildConstants.defaultSoulCartaBackups;

  SoulCartaSettings.fromJson(Map<String, dynamic>? json)
      : virtualHost = json?['virtual_host'] ??
            DestinyChildConstants.defaultSoulCartaVirtualHost,
        path = json?['path'] ?? DestinyChildConstants.defaultSoulCartaPath,
        dataPath = json?['data_path'] ??
            DestinyChildConstants.defaultSoulCartaDataPath,
        backups =
            json?['backups'] ?? DestinyChildConstants.defaultSoulCartaBackups;

  Map<String, String?> toJson() => <String, String?>{
        'virtual_host': virtualHost,
        'path': path,
        'data_path': dataPath,
        'backups': backups,
      };

  @override
  String toString() => toJson().toString();

  String get avatarPath => p.join(path.toString(), 'avatars');

  String get imagePath => p.join(path.toString(), 'images');

  String get live2dPath => p.join(path.toString(), 'live2d');

  String get imageHost => '$virtualHost/images';

  String get live2dHost => '$virtualHost/live2d';
}
