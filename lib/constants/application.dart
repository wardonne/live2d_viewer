import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/utils/utils.dart';
import 'package:window_manager/window_manager.dart';

const double headerBarHeight = 48;
const double footerBarHeight = 49;
const Color toolbarColor = Colors.black26;

class ApplicationConstants {
  static const String appName = 'Live2D Viewer';

  static const String settingsFilename = 'settings.json';

  static const WindowOptions defaultWindowOptions = WindowOptions(
    title: appName,
    size: Size(1440, 768),
    center: true,
    minimumSize: Size(1440, 768),
  );

  static String rootPath = File(Platform.resolvedExecutable).parent.path;
  static String dataPath = PathUtil().join([rootPath, 'data']);
  static String screenshotPath = PathUtil().join([rootPath, 'screenshot']);
  static String cachePath = PathUtil().join([dataPath, 'cached']);
  static String imageCachePath = PathUtil().join([cachePath, 'images']);
  static String httpCachePath = PathUtil().join([cachePath, 'http']);
  static String resourceCachePath = PathUtil().join([cachePath, 'resources']);

  static const String assetsURL =
      'https://static.wardonet.cn/live2d-viewer/assets';
  static const String versionURL = '$assetsURL/version.json';
  static Uri localAssetsURL = Uri(
    scheme: 'http',
    host: 'static.live2d-viewer.local',
  );

  static VirtualHost virtualHost =
      VirtualHost(virtualHost: localAssetsURL.host, folderPath: rootPath);
}
