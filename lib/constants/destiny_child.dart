import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';
import 'package:live2d_viewer/pages/destiny_child/components/character_tabview.dart';
import 'package:live2d_viewer/pages/destiny_child/components/character_view.dart';
import 'package:live2d_viewer/pages/destiny_child/components/soul_carta_tabview.dart';
import 'package:live2d_viewer/pages/destiny_child/components/soul_carta_view.dart';
import 'package:live2d_viewer/controllers/edit_mode_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class DestinyChildConstants {
  static const menuName = 'Destiny Child';

  static EditModeController characterEditModeController =
      EditModeController.disable();
  static EditModeController soulCartaEditModeController =
      EditModeController.disable();

  static CharacterViewController characterViewController =
      CharacterViewController();
  static SoulCartaViewController soulCartaViewController =
      SoulCartaViewController();

  static VisibleController itemListController = VisibleController();

  static const String defaultLive2DVersion = '2';
  static const int defaultHome = 0;

  static String assetsPath = kDebugMode
      ? p.join('assets', 'destiny_child')
      : p.join('data', 'flutter_assets', 'assets', 'destiny_child');
  static const String defaultSoulCartaVirtualHost = 'assets.soul_carta.dc';
  static String defaultSoulCartaPath =
      p.join(Directory.current.path, assetsPath, 'soul_carta');
  static String defaultSoulCartaDataPath =
      p.join(defaultSoulCartaPath, 'data.json');
  static String defaultSoulCartaBackups =
      p.join(defaultSoulCartaPath, 'backups.json');

  static const String defaultCharacterVirtualHost = 'assets.character.dc';
  static String defaultCharacterPath =
      p.join(Directory.current.path, assetsPath, 'character');
  static String defaultCharacterDataPath =
      p.join(defaultCharacterPath, 'data.json');
  static String defaultCharacterBackups =
      p.join(defaultCharacterPath, 'backups.json');

  static String snapshotPath = p.join('Live2DViewer', 'DestinyChild');

  static List<Widget> tabbars = [
    const Tab(text: 'Child'),
    const Tab(text: 'Soul Carta'),
  ];

  static List<WidgetBuilder> tabviews = [
    (context) => CharacterTabView(),
    (context) => SoulCartaTabView(),
  ];

  static List<EditModeController> indexedEditModeController = [
    characterEditModeController,
    soulCartaEditModeController,
  ];

  static List<Widget> detailWindows = [
    CharacterView(),
    SoulCartaView(),
  ];

  static int? activeTabIndex;
}
