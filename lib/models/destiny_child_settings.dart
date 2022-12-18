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
      : soulCartaSettings = SoulCartaSettings(),
        childSettings = ChildSettings();

  DestinyChildSettings.fromJson(Map<String, dynamic>? json)
      : live2dVersion = json?['live2d_version'],
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

  ChildSettings({
    this.virtualHost,
    this.path,
  });

  ChildSettings.fromJson(Map<String, dynamic>? json)
      : virtualHost = json?['virtual_host'],
        path = json?['path'];

  Map<String, String?> toJson() => <String, String?>{
        'virtual_host': virtualHost,
        'path': path,
      };

  @override
  String toString() => toJson().toString();
}

class SoulCartaSettings extends Object {
  String? virtualHost;
  String? path;

  SoulCartaSettings({
    this.virtualHost,
    this.path,
  });

  SoulCartaSettings.fromJson(Map<String, dynamic>? json)
      : virtualHost = json?['virtual_host'],
        path = json?['path'];

  Map<String, String?> toJson() => <String, String?>{
        'virtual_host': virtualHost,
        'path': path,
      };

  @override
  String toString() => toJson().toString();
}
