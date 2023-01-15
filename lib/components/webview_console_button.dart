import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:webview_windows/webview_windows.dart';

class WebviewConsoleButton extends StatelessWidget {
  final WebviewController controller;
  const WebviewConsoleButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ImageButton(
      icon: const Icon(Icons.developer_board),
      onPressed: () async => await controller.openDevTools(),
    );
  }
}
