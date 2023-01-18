import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/widget/widget.dart';

class CharacterAvatar extends StatelessWidget {
  final String avatar;
  CharacterAvatar({super.key, required this.avatar});

  final GlobalKey<CachedNetworkImageState> _imageKey =
      GlobalKey<CachedNetworkImageState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100,
        height: 160,
        child: ContextMenuWrapper(
          itemBuilder: (context) => [
            CachedNetworkImageRefreshMenuItem(
              widgetKey: _imageKey,
            ),
          ],
          child: CachedNetworkImage(
            key: _imageKey,
            width: 100,
            height: 180,
            path: avatar,
            placeholder: ResourceConstants.nikkeCharacterDefaultAvatar,
          ),
        ),
      ),
    );
  }
}