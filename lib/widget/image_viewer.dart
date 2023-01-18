import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final File image;
  const ImageViewer({super.key, required this.image});

  @override
  State<StatefulWidget> createState() {
    return ImageViewerState();
  }
}

class ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ExtendedImage.file(
          widget.image,
          mode: ExtendedImageMode.gesture,
          fit: BoxFit.contain,
          width: double.infinity,
          filterQuality: FilterQuality.high,
          initGestureConfigHandler: (state) => GestureConfig(
            cacheGesture: false,
          ),
        ),
      ),
    );
  }
}
