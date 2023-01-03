import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:window_manager/window_manager.dart';

class CloseWindowButton extends StatelessWidget {
  const CloseWindowButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      hoverColor: Colors.red,
      onPressed: () async {
        await windowManager.close();
      },
      splashRadius: defaultActionIconButtonSplashRadius,
    );
  }
}
