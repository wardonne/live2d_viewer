import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/settings/settings.dart';
import 'package:window_manager/window_manager.dart';

import 'constants/routes.dart';
import 'router/router.dart';
import 'package:path/path.dart' as p;

class Live2DViewer extends StatelessWidget {
  const Live2DViewer({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Live2D Viewer',
      theme: ThemeData(
        brightness: Brightness.dark,
        iconTheme: const IconThemeData(
          color: Colors.white70,
        ),
      ),
      initialRoute: index,
      routes: routes,
    );
  }
}

class CustomerWindowListener extends WindowListener {
  @override
  void onWindowMaximize() {
    windowManager.getSize().then((value) {});
  }

  @override
  void onWindowUnmaximize() {
    windowManager.getSize().then((value) {});
  }

  @override
  void onWindowResized() {
    windowManager.getSize().then((value) {});
  }
}

Future<Settings> loadSettings() async {
  try {
    final settingsPath = kDebugMode
        ? p.join('assets', 'application', 'settings.json')
        : p.join('data', 'flutter_assets', 'asssets', 'application',
            'settings.json');
    final settingsFile = File(p.join(Directory.current.path, settingsPath));
    final content = await settingsFile.readAsString();
    final json = jsonDecode(content);
    return Settings.fromJson(json);
  } catch (e) {
    log(e.toString(), time: DateTime.now());
    return Settings.init();
  }
}
