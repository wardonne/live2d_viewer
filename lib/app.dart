import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/models/settings.dart';
import 'package:window_manager/window_manager.dart';

import 'constant/routes.dart';
import 'router/router.dart';

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
    var content =
        await rootBundle.loadString('assets/application/settings.json');
    var json = jsonDecode(content);
    return Settings.fromJson(json);
  } catch (e) {
    return Settings.init();
  }
}
