import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:live2d_viewer/models/destiny_child_settings.dart';
import 'package:live2d_viewer/models/webview_settings.dart';

class Settings extends Object {
  WebviewSettings? webviewSettings;
  DestinyChildSettings? destinyChildSettings;

  Settings({
    this.webviewSettings,
    this.destinyChildSettings,
  });

  Settings.init()
      : webviewSettings = WebviewSettings(),
        destinyChildSettings = DestinyChildSettings.init();

  Settings.fromJson(Map<String, dynamic>? json)
      : webviewSettings = WebviewSettings.fromJson(json?['webview']),
        destinyChildSettings =
            DestinyChildSettings.fromJson(json?['destiny_child']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'destiny_child': destinyChildSettings,
      };

  @override
  String toString() => toJson().toString();

  Future<void> updateSettings() async {
    var file = File(kDebugMode
        ? '${Directory.current.path}/assets/application/settings.json'
        : '${Directory.current.path}/data/flutter_assets/assets/application/settings.json');
    if (await file.exists()) {
      await file.copy(kDebugMode
          ? '${Directory.current.path}/assets/application/settings.backup.json'
          : '${Directory.current.path}/data/flutter_data/assets/application/settings.backup.json');
    }

    var encoder = const JsonEncoder.withIndent('  ');
    var json = encoder.convert(toJson());
    await file.writeAsString(json);
  }
}
