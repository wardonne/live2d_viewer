import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:live2d_viewer/models/settings/application_settings.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/models/settings/nikke_settings.dart';
import 'package:live2d_viewer/models/settings/webview_settings.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class Settings extends Object {
  ApplicationSettings? applicationSettings;
  WebviewSettings? webviewSettings;
  DestinyChildSettings? destinyChildSettings;
  NikkeSettings? nikkeSettings;

  Settings({
    this.applicationSettings,
    this.webviewSettings,
    this.destinyChildSettings,
    this.nikkeSettings,
  });

  Settings.init()
      : applicationSettings = ApplicationSettings.init(),
        webviewSettings = WebviewSettings.init(),
        destinyChildSettings = DestinyChildSettings.init(),
        nikkeSettings = NikkeSettings.init();

  Settings.fromJson(Map<String, dynamic>? json)
      : applicationSettings =
            ApplicationSettings.fromJson(json?['application']),
        webviewSettings = WebviewSettings.fromJson(json?['webview']),
        destinyChildSettings =
            DestinyChildSettings.fromJson(json?['destiny_child']),
        nikkeSettings = NikkeSettings.fromJson(json?['nikke']);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'application': applicationSettings,
        'webview': webviewSettings,
        'destiny_child': destinyChildSettings,
        'nikke': nikkeSettings,
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
