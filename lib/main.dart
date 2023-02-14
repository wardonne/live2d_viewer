import 'dart:io';

import 'package:auto_updater/auto_updater.dart';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/providers/locale_provider.dart';
import 'package:live2d_viewer/utils/registry_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

import 'app.dart';

void main() async {
  DartVLC.initialize();

  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  await hotKeyManager.unregisterAll();

  if (kReleaseMode) {
    String feedURL = 'https://appcast.wardonet.cn/live2d-viewer/appcast.xml';
    await autoUpdater.setFeedURL(feedURL);
    await autoUpdater.setScheduledCheckInterval(3600);
    await autoUpdater.checkForUpdates(inBackground: true);
  }

  hotKeyManager.register(
    HotKey(KeyCode.f11, scope: HotKeyScope.inapp),
    keyDownHandler: (hotKey) async =>
        windowManager.setFullScreen(!await windowManager.isFullScreen()),
  );

  windowManager.waitUntilReadyToShow(
    ApplicationConstants.defaultWindowOptions,
    () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );

  final documentDirectory = await getApplicationDocumentsDirectory();
  final storageDirectory =
      Directory(p.join(documentDirectory.path, ApplicationConstants.appName));
  if (!storageDirectory.existsSync()) {
    storageDirectory.createSync(recursive: true);
  }

  RegistryUtil.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) {
        return LocaleProvider(const Locale('zh', 'CN'));
      }),
    ],
    child: const Live2DViewer(),
  ));
}
