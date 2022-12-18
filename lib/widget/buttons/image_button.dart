import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final Widget icon;
  final void Function() onPressed;

  const ImageButton({super.key, required this.icon, required this.onPressed});

  ImageButton.fromFile(
      {super.key, required String filepath, required this.onPressed})
      : icon = Image.file(File(filepath));

  ImageButton.fromNetwork(
      {super.key, required String imageUrl, required this.onPressed})
      : icon = Image.network(imageUrl);

  ImageButton.fromMemory(
      {super.key, required Uint8List bytes, required this.onPressed})
      : icon = Image.memory(bytes);

  ImageButton.fromAsset(
      {super.key, required String asset, required this.onPressed})
      : icon = Image.asset(asset);

  ImageButton.fromIcon(
      {super.key, required IconData icon, required this.onPressed})
      : icon = Icon(icon);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: icon,
        ),
      ),
    );
  }
}
