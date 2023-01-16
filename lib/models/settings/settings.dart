import 'package:live2d_viewer/models/settings/application_settings.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';

class Settings extends Object {
  ApplicationSettings? applicationSettings;
  DestinyChildSettings? destinyChildSettings;

  Settings({
    this.applicationSettings,
    this.destinyChildSettings,
  });

  Settings.init()
      : applicationSettings = ApplicationSettings.init(),
        destinyChildSettings = DestinyChildSettings.init();

  Settings.fromJson(Map<String, dynamic>? json)
      : applicationSettings =
            ApplicationSettings.fromJson(json?['application']),
        destinyChildSettings =
            DestinyChildSettings.fromJson(json?['destiny_child']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'application': applicationSettings,
        'destiny_child': destinyChildSettings,
      };

  @override
  String toString() => toJson().toString();
}
