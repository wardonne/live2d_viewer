import 'package:live2d_viewer/constants/destiny_child.dart';

class DestinyChildSettings extends Object {
  String? live2dVersion;
  int? defaultHome;
  SoulCartaSettings? soulCartaSettings;
  ChildSettings? childSettings;

  DestinyChildSettings({
    this.live2dVersion,
    this.defaultHome,
    this.soulCartaSettings,
    this.childSettings,
  });

  DestinyChildSettings.init()
      : live2dVersion = DestinyChildConstants.defaultLive2DVersion,
        defaultHome = DestinyChildConstants.defaultHome,
        soulCartaSettings = SoulCartaSettings.init(),
        childSettings = ChildSettings.init();

  DestinyChildSettings.fromJson(Map<String, dynamic>? json)
      : live2dVersion = json?['live2d_version'] ??
            DestinyChildConstants.defaultLive2DVersion,
        defaultHome =
            json?['default_home'] ?? DestinyChildConstants.defaultHome,
        soulCartaSettings = SoulCartaSettings.fromJson(json?['soul_carta']),
        childSettings = ChildSettings.fromJson(json?['child']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'live2d_version': live2dVersion,
        'default_home': defaultHome,
        'soul_carta': soulCartaSettings?.toJson(),
        'child': childSettings?.toJson(),
      };

  @override
  String toString() => toJson().toString();
}

class ChildSettings extends Object {
  String? virtualHost;
  String? path;
  String? dataPath;
  String? backups;

  ChildSettings({
    this.virtualHost,
    this.path,
    this.dataPath,
    this.backups,
  });

  ChildSettings.init()
      : virtualHost = DestinyChildConstants.defaultChildVirtualHost,
        path = DestinyChildConstants.defaultChildPath,
        dataPath = DestinyChildConstants.defaultChildDataPath,
        backups = DestinyChildConstants.defaultChildBackups;

  ChildSettings.fromJson(Map<String, dynamic>? json)
      : virtualHost = json?['virtual_host'] ??
            DestinyChildConstants.defaultChildVirtualHost,
        path = json?['path'] ?? DestinyChildConstants.defaultChildPath,
        dataPath =
            json?['data_path'] ?? DestinyChildConstants.defaultChildDataPath,
        backups =
            json?['backup_list'] ?? DestinyChildConstants.defaultChildBackups;

  Map<String, String?> toJson() => <String, String?>{
        'virtual_host': virtualHost,
        'path': path,
        'data_path': dataPath,
        'backups': backups,
      };

  @override
  String toString() => toJson().toString();

  String get avatarPath => '$path/avatars';

  String get live2dPath => '$path/live2d';

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

  String get avatarPath => '$path/avatars';

  String get imagePath => '$path/images';

  String get live2dPath => '$path/live2d';

  String get imageHost => '$virtualHost/images';

  String get live2dHost => '$virtualHost/live2d';
}
