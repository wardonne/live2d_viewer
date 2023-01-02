import 'dart:convert';
import 'dart:io';

import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/models/destiny_child/soul_carta.dart';
import 'package:live2d_viewer/services/backup_service.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';

class SoulCartaService extends DestinyChildService {
  final BackupService backupService;
  SoulCartaService(super.destinyChildSettings)
      : backupService =
            BackupService(destinyChildSettings.soulCartaSettings!.backups!);

  List<SoulCarta> load() {
    var items = <SoulCarta>[];
    final file = File(destinyChildSettings.soulCartaSettings!.dataPath!);
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      final data = jsonDecode(content);
      for (final item in data) {
        items.add(SoulCarta.fromJson(item));
      }
    }
    return items;
  }

  void save(List<SoulCarta> data, {bool backupBeforeSave = true}) {
    final dateTime = DateTime.now();
    final dataPath = destinyChildSettings.soulCartaSettings!.dataPath!;
    final file = File(dataPath);
    if (file.existsSync()) {
      if (backupBeforeSave) {
        final backupFile =
            '${file.parent.path}/data.backup.${dateTime.millisecondsSinceEpoch}.json';
        file.copySync(backupFile);
        backupService.add(backupFile);
      }
    } else {
      file.createSync(recursive: true);
    }
    var encoder = const JsonEncoder.withIndent('  ');
    var content = encoder.convert(data);
    file.writeAsStringSync(content);
  }

  void recover() {
    final file = backupService.latestExists;
    if (file != null) {
      file.copySync(destinyChildSettings.soulCartaSettings!.dataPath!);
    }
  }

  static void initViewWindow(SoulCarta data) {
    DestinyChildConstants.soulCartaViewController.setData(data);
  }

  static void clearViewWindow() {
    DestinyChildConstants.soulCartaViewController.clear();
  }
}
