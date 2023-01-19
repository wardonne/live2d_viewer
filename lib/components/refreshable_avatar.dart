import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/cached_network_image.dart';
import 'package:live2d_viewer/widget/wrappers/context_menu_wrapper.dart';

import 'cached_network_image_refresh_button.dart';

class RefreshableAvatar extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final String? placeholder;
  final bool contextMenu;

  RefreshableAvatar({
    super.key,
    required this.path,
    required this.width,
    required this.height,
    this.placeholder,
    this.contextMenu = true,
  });

  final _imageKey = GlobalKey<CachedNetworkImageState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: contextMenu
            ? ContextMenuWrapper(
                child: CachedNetworkImage(
                  key: _imageKey,
                  width: width,
                  height: height,
                  path: path,
                  placeholder: placeholder,
                ),
                itemBuilder: (context) => [
                  CachedNetworkImageRefreshMenuItem(
                    widgetKey: _imageKey,
                  ),
                ],
              )
            : CachedNetworkImage(
                key: _imageKey,
                width: width,
                height: height,
                path: path,
                placeholder: placeholder,
              ),
      ),
    );
  }
}
