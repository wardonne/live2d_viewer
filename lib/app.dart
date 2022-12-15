import 'package:flutter/material.dart';
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
