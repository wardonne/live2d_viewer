import 'package:flutter/material.dart';
import 'package:live2d_viewer/constant/settings.dart';
import 'package:window_manager/window_manager.dart';

class MinimizeWindowButton extends StatelessWidget {
  const MinimizeWindowButton({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.minimize),
      onPressed: () async {
        await windowManager.minimize();
      },
      splashRadius: defaultActionIconButtonSplashRadius,
    );
  }
}