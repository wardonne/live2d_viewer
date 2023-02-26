import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/controllers/load_controller.dart';

class SoulCartaAvatar extends StatelessWidget {
  final String avatar;
  final LoadController controller;
  const SoulCartaAvatar({
    super.key,
    required this.avatar,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.load) {
          return RefreshableAvatar(path: avatar, width: 100, height: 100);
        } else {
          return const SizedBox(
            width: 100,
            height: 100,
            child: LoadingAnimation(),
          );
        }
      },
    );
  }
}
