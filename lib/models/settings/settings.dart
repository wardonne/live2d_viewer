import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/models/settings/webview_settings.dart';
import 'package:path/path.dart' as p;

class Settings extends Object {
  WebviewSettings? webviewSettings;
  DestinyChildSettings? destinyChildSettings;

  Settings({
    this.webviewSettings,
    this.destinyChildSettings,
  });

  Settings.init()
      : webviewSettings = WebviewSettings.init(),
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

  static final _devPath = p.join(
    Directory.current.path,
    'assets',
    'application',
  );

  static final _releasePath = p.joinAll([
    Directory.current.path,
    'data',
    'flutter_assets',
    'assets',
    'application',
  ]);

  Future<void> updateSettings() async {
    var file = File(kDebugMode
        ? p.join(_devPath, 'settings.json')
        : p.join(_releasePath, 'settings.json'));
    if (await file.exists()) {
      await file.copy(kDebugMode
          ? p.join(_devPath, 'settings.backup.json')
          : p.join(_releasePath, 'settings.backup.json'));
    }

    var encoder = const JsonEncoder.withIndent('  ');
    var json = encoder.convert(toJson());
    await file.writeAsString(json);
  }
}
