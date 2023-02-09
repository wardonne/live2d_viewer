import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/components/refreshable_avatar.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/controllers/load_controller.dart';

class CharacterAvatar extends StatelessWidget {
  final String avatar;
  final bool contextMenu;
  final LoadController controller;
  const CharacterAvatar({
    super.key,
    required this.avatar,
    required this.controller,
    this.contextMenu = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.load) {
          return RefreshableAvatar(
            path: avatar,
            width: 100,
            height: 180,
            contextMenu: contextMenu,
            queueKey: NikkeConstants.name,
          );
        } else {
          return const SizedBox(
            height: 180,
            width: 100,
            child: LoadingAnimation(),
          );
        }
      },
    );
  }
}
