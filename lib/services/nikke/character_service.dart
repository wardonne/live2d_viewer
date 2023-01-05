import 'dart:convert';
import 'dart:io';

import 'package:live2d_viewer/constants/nikke.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/services/backup_service.dart';
import 'package:live2d_viewer/services/nikke/nikke_service.dart';
import 'package:path/path.dart' as p;

class CharacterService extends NikkeService {
  final BackupService backupService;

  CharacterService(super.nikkeSettings)
      : backupService =
            BackupService(nikkeSettings.characterSettings!.backups!);

  List<Character> load() {
    var items = <Character>[];
    final file = File(nikkeSettings.characterSettings!.dataPath!);
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      final data = jsonDecode(content);
      for (final item in data) {
        items.add(Character.fromJson(item));
      }
    }
    return items;
  }

  void save(List<Character> data, {bool backupBeforeSave = true}) {
    final dataPath = nikkeSettings.characterSettings!.dataPath!;
    final file = File(dataPath);
    if (file.existsSync()) {
      if (backupBeforeSave) {
        final dateTime = DateTime.now();
        final backupFile = p.join(file.parent.path,
            'data.backup.${dateTime.millisecondsSinceEpoch}.json');
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
      file.copySync(nikkeSettings.characterSettings!.dataPath!);
    }
  }

  static void initViewWindow(Character data, {int? skinIndex}) {
    NikkeConstants.characterViewController.setData(data, skinIndex: skinIndex);
  }
}
