import 'dart:convert';
import 'dart:io';

import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/models/destiny_child/child.dart';
import 'package:live2d_viewer/services/backup_service.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';

class ChildService extends DestinyChildService {
  final BackupService backupService;
  ChildService(super.destinyChildSettings)
      : backupService =
            BackupService(destinyChildSettings.childSettings!.backups!);

  List<Child> load() {
    var items = <Child>[];
    final file = File(destinyChildSettings.childSettings!.dataPath!);
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      final data = jsonDecode(content);
      for (final item in data) {
        items.add(Child.fromJson(item));
      }
    }
    return items;
  }

  void save(List<Child> data, {bool backupBeforeSave = true}) {
    final dateTime = DateTime.now();
    final dataPath = destinyChildSettings.childSettings!.dataPath!;
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
      file.copySync(destinyChildSettings.childSettings!.dataPath!);
    }
  }

  static void initViewWindow(Child data) {
    DestinyChildConstant.childViewController.setData(data);
  }

  static void loadOptions(Skin skin, {required String modelJson}) {
    final content = File(modelJson).readAsStringSync();
    final model = jsonDecode(content);
    skin.expressions = loadExpressions(model);
    skin.motions = loadMotions(model);
  }

  static List<Expression> loadExpressions(Map<String, dynamic> model) {
    final expressions = model['expressions'] as List<dynamic>?;
    return expressions
            ?.map((expression) =>
                Expression(name: expression['name'], file: expression['file']))
            .toList() ??
        [];
  }

  static List<Motion> loadMotions(Map<String, dynamic> model) {
    final motions = model['motions'] as Map<String, dynamic>?;
    final List<Motion> result = [];
    motions?.forEach((name, value) {
      result.add(Motion(name: name));
    });
    return result;
  }
}
