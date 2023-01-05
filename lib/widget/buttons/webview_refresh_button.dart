import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:webview_windows/webview_windows.dart';

class WebviewRefreshButton extends StatelessWidget {
  final WebviewController controller;

  const WebviewRefreshButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ImageButton(
      icon: const Icon(Icons.refresh_rounded, size: 20),
      onPressed: () async => await controller.reload(),
    );
  }
}
