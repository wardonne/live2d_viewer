import 'package:live2d_viewer/models/settings/application_settings.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/models/settings/nikke_settings.dart';

class Settings extends Object {
  ApplicationSettings? applicationSettings;
  DestinyChildSettings? destinyChildSettings;
  NikkeSettings? nikkeSettings;

  Settings({
    this.applicationSettings,
    this.destinyChildSettings,
    this.nikkeSettings,
  });

  Settings.init()
      : applicationSettings = ApplicationSettings.init(),
        destinyChildSettings = DestinyChildSettings.init(),
        nikkeSettings = NikkeSettings.init();

  Settings.fromJson(Map<String, dynamic>? json)
      : applicationSettings =
            ApplicationSettings.fromJson(json?['application']),
        destinyChildSettings =
            DestinyChildSettings.fromJson(json?['destiny_child']),
        nikkeSettings = NikkeSettings.fromJson(json?['nikke']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'application': applicationSettings,
        'destiny_child': destinyChildSettings,
        'nikke': nikkeSettings,
      };

  @override
  String toString() => toJson().toString();
}
