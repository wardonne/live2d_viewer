import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/settings.dart';
import 'package:window_manager/window_manager.dart';

class MaximizeWindowButton extends StatefulWidget {
  const MaximizeWindowButton({super.key});

  @override
  State<StatefulWidget> createState() {
    return MaximizeWindowButtonState();
  }
}

class MaximizeWindowButtonState extends State<MaximizeWindowButton> {
  bool isMaximized = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isMaximized ? Icons.fullscreen_exit : Icons.fullscreen),
      onPressed: () async {
        isMaximized ? windowManager.restore() : windowManager.maximize();
        setState(() {
          isMaximized = !isMaximized;
        });
      },
      splashRadius: defaultActionIconButtonSplashRadius,
    );
  }
}
