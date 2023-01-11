import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';

void main() async {
  DartVLC.initialize();

  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  await hotKeyManager.unregisterAll();

  // if (kReleaseMode) {
  //   String feedURL =
  //       'https://gitee.com/wardonet/releases/raw/master/live2d_viewer/appcast.xml';
  //   await autoUpdater.setFeedURL(feedURL);
  //   await autoUpdater.checkForUpdates(inBackground: false);
  //   await autoUpdater.setScheduledCheckInterval(3600);
  // }

  hotKeyManager.register(
    HotKey(KeyCode.f11, scope: HotKeyScope.inapp),
    keyDownHandler: (hotKey) async =>
        windowManager.setFullScreen(!await windowManager.isFullScreen()),
  );

  windowManager.addListener(CustomerWindowListener());

  windowManager.waitUntilReadyToShow(defaultWindowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  final settings = await loadSettings();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => SettingsProvider(settings: settings)),
    ],
    child: const Live2DViewer(),
  ));
}
