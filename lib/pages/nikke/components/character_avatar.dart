import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/refreshable_avatar.dart';
import 'package:live2d_viewer/widget/widget.dart';

class CharacterAvatar extends StatelessWidget {
  final String avatar;
  final bool contextMenu;
  CharacterAvatar({
    super.key,
    required this.avatar,
    this.contextMenu = true,
  });

  final GlobalKey<CachedNetworkImageState> _imageKey =
      GlobalKey<CachedNetworkImageState>();

  @override
  Widget build(BuildContext context) {
    return RefreshableAvatar(
      path: avatar,
      width: 100,
      height: 180,
      contextMenu: contextMenu,
    );
  }
}
