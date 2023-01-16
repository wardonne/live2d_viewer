import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';

class Settings extends Object {
  DestinyChildSettings? destinyChildSettings;

  Settings({
    this.destinyChildSettings,
  });

  Settings.init() : destinyChildSettings = DestinyChildSettings.init();

  Settings.fromJson(Map<String, dynamic>? json)
      : destinyChildSettings =
            DestinyChildSettings.fromJson(json?['destiny_child']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'destiny_child': destinyChildSettings,
      };

  @override
  String toString() => toJson().toString();
}
