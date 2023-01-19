import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/refreshable_avatar.dart';
import 'package:live2d_viewer/constants/constants.dart';

class CharacterAvatar extends StatelessWidget {
  final String avatar;
  final bool contextMenu;
  const CharacterAvatar({
    super.key,
    required this.avatar,
    this.contextMenu = true,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshableAvatar(
      path: avatar,
      placeholder: ResourceConstants.destinyChildDefaultAvatar,
      width: 100,
      height: 180,
      contextMenu: contextMenu,
    );
  }
}
