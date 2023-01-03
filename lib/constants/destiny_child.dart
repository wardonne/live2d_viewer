import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/pages/destiny_child/components/child_tabview.dart';
import 'package:live2d_viewer/pages/destiny_child/components/child_view.dart';
import 'package:live2d_viewer/pages/destiny_child/components/items.dart';
import 'package:live2d_viewer/pages/destiny_child/components/soul_carta_tabview.dart';
import 'package:live2d_viewer/pages/destiny_child/components/soul_carta_view.dart';
import 'package:live2d_viewer/controllers/edit_mode_controller.dart';
import 'package:path/path.dart' as p;

class DestinyChildConstants {
  static const menuName = 'Destiny Child';

  static EditModeController childEditModeController =
      EditModeController.disable();
  static EditModeController soulCartaEditModeController =
      EditModeController.disable();

  static ChildViewController childViewController = ChildViewController();
  static SoulCartaViewController soulCartaViewController =
      SoulCartaViewController();

  static ItemListController itemListController = ItemListController();

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

  static const String defaultChildVirtualHost = 'assets.child.dc';
  static String defaultChildPath =
      p.join(Directory.current.path, assetsPath, 'child');
  static String defaultChildDataPath = p.join(defaultChildPath, 'data.json');
  static String defaultChildBackups = p.join(defaultChildPath, 'backups.json');

  static List<Widget> tabbars = [
    const Tab(text: 'Child'),
    const Tab(text: 'Soul Carta'),
  ];

  static List<WidgetBuilder> tabviews = [
    (context) => ChildTabView(),
    (context) => SoulCartaTabView(),
  ];

  static List<EditModeController> indexedEditModeController = [
    childEditModeController,
    soulCartaEditModeController,
  ];

  static List<Widget> detailWindows = [
    ChildView(),
    SoulCartaView(),
  ];

  static int? activeTabIndex;
}
