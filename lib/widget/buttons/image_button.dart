import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final Widget icon;
  final String? tooltip;
  final void Function() onPressed;

  const ImageButton({
    super.key,
    required this.icon,
    this.tooltip,
    required this.onPressed,
  });

  ImageButton.fromFile({
    super.key,
    required String filepath,
    this.tooltip,
    required this.onPressed,
  }) : icon = Image.file(File(filepath));

  ImageButton.fromNetwork({
    super.key,
    required String imageUrl,
    this.tooltip,
    required this.onPressed,
  }) : icon = Image.network(imageUrl);

  ImageButton.fromMemory({
    super.key,
    required Uint8List bytes,
    this.tooltip,
    required this.onPressed,
  }) : icon = Image.memory(bytes);

  ImageButton.fromAsset({
    super.key,
    required String asset,
    this.tooltip,
    required this.onPressed,
  }) : icon = Image.asset(asset);

  ImageButton.fromIcon({
    super.key,
    required IconData icon,
    this.tooltip,
    required this.onPressed,
  }) : icon = Icon(icon);

  @override
  Widget build(BuildContext context) {
    final button = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: icon,
        ),
      ),
    );
    return tooltip != null
        ? Tooltip(
            message: tooltip,
            child: button,
          )
        : button;
  }
}
