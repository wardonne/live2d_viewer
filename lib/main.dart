import 'package:flutter/material.dart';
import 'package:live2d_viewer/constant/settings.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  windowManager.addListener(CustomerWindowListener());

  windowManager.waitUntilReadyToShow(defaultWindowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  settings = await loadSettings();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (_) => SettingsProvider(settings: settings)),
    ],
    child: const Live2DViewer(),
  ));
}
