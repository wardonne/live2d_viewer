import 'dart:convert';
import 'dart:io';

import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/models/preview_data/image_preview_data.dart';
import 'package:live2d_viewer/models/preview_data/live2d_preview_data.dart';
import 'package:live2d_viewer/models/preview_data/preview_data.dart';
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

  void initViewWindow({
    required bool useLive2d,
    required SoulCarta data,
  }) {
    if (useLive2d) {
      initLive2DWindow(data);
    } else {
      initImageWindow(data);
    }
  }

  static void clearViewWindow() {
    DestinyChildConstant.soulCartaViewController.clear();
  }

  void initLive2DWindow(SoulCarta data) {
    DestinyChildConstant.soulCartaViewController.setData(PreviewData(
      data: Live2DPreviewData(
        title: data.name ?? data.live2d ?? data.avatar,
        live2dVersion: destinyChildSettings.live2dVersion ?? '2',
        live2dSrc: data.live2d!,
        backgroundImage: data.image,
        virtualHost: destinyChildSettings.soulCartaSettings!.virtualHost,
        folderPath: destinyChildSettings.soulCartaSettings!.path,
      ),
    ));
  }

  void initImageWindow(SoulCarta data) {
    DestinyChildConstant.soulCartaViewController
        .setData(PreviewData<ImagePreviewData>(
      data: ImagePreviewData(
        title: data.name ?? data.avatar,
        imageSrc:
            '${destinyChildSettings.soulCartaSettings!.imagePath}/${data.image}',
      ),
    ));
  }
}
