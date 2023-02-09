import 'package:flutter/material.dart';

class BrokenImage extends StatelessWidget {
  final double? width;
  final double? height;
  const BrokenImage({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: const Icon(Icons.broken_image),
    );
  }
}
