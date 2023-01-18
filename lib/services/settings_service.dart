import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/models/settings/settings.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class SettingsService {
  static const String settingsFilename = 'settings.json';

  static Future<File> getSettingsFile() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    return File(p.join(
      documentDirectory.path,
      ApplicationConstants.appName,
      ApplicationConstants.settingsFilename,
    ));
  }

  static Future<void> updateSettings(Settings settings) async {
    const encoder = JsonEncoder.withIndent('  ');
    final settingsFile = await getSettingsFile();
    final jsonStr = encoder.convert(settings.toJson());
    settingsFile.writeAsString(jsonStr);
  }

  static Future<Settings> loadSettings() async {
    try {
      final settingsFile = await getSettingsFile();
      final content = await settingsFile.readAsString();
      final json = jsonDecode(content) as Map<String, dynamic>;
      return Settings.fromJson(json);
    } catch (e) {
      log(e.toString(), time: DateTime.now());
      return Settings.init();
    }
  }
}
