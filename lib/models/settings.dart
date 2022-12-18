import 'dart:convert';
import 'dart:io';

import 'package:live2d_viewer/models/destiny_child_settings.dart';

class Settings extends Object {
  DestinyChildSettings? destinyChildSettings;

  Settings({this.destinyChildSettings});

  Settings.init() : destinyChildSettings = DestinyChildSettings();

  Settings.fromJson(Map<String, dynamic>? json)
      : destinyChildSettings =
            DestinyChildSettings.fromJson(json?['destiny_child']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'destiny_child': destinyChildSettings,
      };

  @override
  String toString() => toJson().toString();

  Future<void> updateSettings() async {
    var file =
        File('${Directory.current.path}/assets/application/settings.json');
    await file.copy(
        '${Directory.current.path}/assets/application/settings.backup.json');
    var encoder = const JsonEncoder.withIndent('  ');
    var json = encoder.convert(toJson());
    await file.writeAsString(json);
  }
}
