import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:path/path.dart' as p;

const double headerBarHeight = 48;
const double footerBarHeight = 49;
const Color toolbarColor = Colors.black26;

class ApplicationConstants {
  static const String defaultSidebar = '0';

  static const String appName = 'Live2D Viewer';

  static const String settingsFilename = 'settings.json';

  static const WindowOptions defaultWindowOptions = WindowOptions(
    title: appName,
    size: Size(1440, 768),
    center: true,
    minimumSize: Size(1440, 768),
  );

  static String cachePath =
      p.join(File(Platform.resolvedExecutable).parent.path, 'data', 'cached');
  static String imageCachePath = p.join(cachePath, 'images');
  static String httpCachePath = p.join(cachePath, 'http');
  static String resourceCachePath = p.join(cachePath, 'resources');

  static const String assetsURL =
      'https://static.wardonet.cn/live2d-viewer/assets';
  static const String localAssetsURL = 'static.live2d-viewer.local';
}
