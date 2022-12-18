import 'package:live2d_viewer/constant/destiny_child.dart';

class DestinyChildSettings extends Object {
  String? live2dVersion;
  SoulCartaSettings? soulCartaSettings;
  ChildSettings? childSettings;

  DestinyChildSettings({
    this.live2dVersion,
    this.soulCartaSettings,
    this.childSettings,
  });

  DestinyChildSettings.init()
      : live2dVersion = DestinyChildConstant.defaultLive2DVersion,
        soulCartaSettings = SoulCartaSettings.init(),
        childSettings = ChildSettings.init();

  DestinyChildSettings.fromJson(Map<String, dynamic>? json)
      : live2dVersion = json?['live2d_version'] ??
            DestinyChildConstant.defaultLive2DVersion,
        soulCartaSettings = SoulCartaSettings.fromJson(json?['soul_carta']),
        childSettings = ChildSettings.fromJson(json?['child']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'live2d_version': live2dVersion,
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

  ChildSettings({
    this.virtualHost,
    this.path,
    this.dataPath,
  });

  ChildSettings.init()
      : virtualHost = DestinyChildConstant.defaultChildVirtualHost,
        path = DestinyChildConstant.defaultChildPath,
        dataPath = DestinyChildConstant.defaultChildDataPath;

  ChildSettings.fromJson(Map<String, dynamic>? json)
      : virtualHost = json?['virtual_host'] ??
            DestinyChildConstant.defaultChildVirtualHost,
        path = json?['path'] ?? DestinyChildConstant.defaultChildPath,
        dataPath =
            json?['data_path'] ?? DestinyChildConstant.defaultChildDataPath;

  Map<String, String?> toJson() => <String, String?>{
        'virtual_host': virtualHost,
        'path': path,
        'data_path': dataPath,
      };

  @override
  String toString() => toJson().toString();
}

class SoulCartaSettings extends Object {
  String? virtualHost;
  String? path;
  String? dataPath;

  SoulCartaSettings({
    this.virtualHost,
    this.path,
    this.dataPath,
  });

  SoulCartaSettings.init()
      : virtualHost = DestinyChildConstant.defaultSoulCartaVirtualHost,
        path = DestinyChildConstant.defaultSoulCartaPath,
        dataPath = DestinyChildConstant.defaultSoulCartaDataPath;

  SoulCartaSettings.fromJson(Map<String, dynamic>? json)
      : virtualHost = json?['virtual_host'] ??
            DestinyChildConstant.defaultSoulCartaVirtualHost,
        path = json?['path'] ?? DestinyChildConstant.defaultSoulCartaPath,
        dataPath =
            json?['data_path'] ?? DestinyChildConstant.defaultSoulCartaDataPath;

  Map<String, String?> toJson() => <String, String?>{
        'virtual_host': virtualHost,
        'path': path,
        'data_path': dataPath,
      };

  @override
  String toString() => toJson().toString();

  String get avatarPath => '$path/avatars';

  String get imagePath => '$path/images';

  String get live2dPath => '$path/live2d';

  String get imageHost => '$virtualHost/images';

  String get live2dHost => '$virtualHost/live2d';
}
