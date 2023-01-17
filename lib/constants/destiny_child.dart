import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/controllers/edit_mode_controller.dart';
import 'package:live2d_viewer/utils/path_util.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class DestinyChildConstants {
  static String menuName = S.current.destinyChild;

  static EditModeController characterEditModeController =
      EditModeController.disable();
  static EditModeController soulCartaEditModeController =
      EditModeController.disable();

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

  static List<WidgetBuilder> tabviews = [];

  static List<EditModeController> indexedEditModeController = [
    characterEditModeController,
    soulCartaEditModeController,
  ];

  static List<Widget> detailWindows = [];

  static int? activeTabIndex;

  static const String assetsURL =
      '${ApplicationConstants.assetsURL}/destiny-child';
  static const String characterDataURL = '$assetsURL/character/data.json';
  static const String characterAvatarURL = '$assetsURL/character/avatars';
  static const String characterLive2DURL = '$assetsURL/character/live2d';

  static const String soulCartaDataURL = '$assetsURL/soul_carta/data.json';
  static const String soulCartaAvatarURL = '$assetsURL/soul_carta/avatars';
  static const String soulCartaImageURL = '$assetsURL/soul_carta/images';
  static const String soulCartaLive2DURL = '$assetsURL/soul_carta/live2d';

  static String resourceCachePath = PathUtil()
      .join([ApplicationConstants.resourceCachePath, 'destiny_child']);
  static String screenshotPath =
      PathUtil().join([ApplicationConstants.screenshotPath, 'destiny_child']);
}
