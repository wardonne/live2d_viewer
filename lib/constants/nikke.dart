import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/controllers/edit_mode_controller.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';
import 'package:live2d_viewer/pages/nikke/components/character_view.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class NikkeConstants {
  static const menuName = 'Nikke';

  static VisibleController itemListController = VisibleController();

  static EditModeController characterEditModeController =
      EditModeController.disable();

  static CharacterViewController characterViewController =
      CharacterViewController();

  static String assetsPath = kDebugMode
      ? p.join('assets', 'nikke')
      : p.join('data', 'flutter_assets', 'assets', 'nikke');

  static const String defaultCharacterVirtualHost = 'assets.character.nikke';
  static String defaultCharacterPath =
      p.join(Directory.current.path, assetsPath, 'character');
  static String defaultCharacterDataPath =
      p.join(defaultCharacterPath, 'data.json');
  static String defaultCharacterBackups =
      p.join(defaultCharacterPath, 'backups.json');

  static String snapshotPath = p.join('Live2DViewer', 'Nikke');

  static const String assetsURL = "${ApplicationConstants.assetsURL}/nikke";
}
