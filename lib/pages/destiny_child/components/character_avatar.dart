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
            placeholder: ResourceConstants.destinyChildDefaultAvatar,
            width: 100,
            height: 180,
            contextMenu: contextMenu,
            queueKey: DestinyChildConstants.name,
          );
        } else {
          return const SizedBox(
            width: 100,
            height: 180,
            child: LoadingAnimation(),
          );
        }
      },
    );
  }
}
