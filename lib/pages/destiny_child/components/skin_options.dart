import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/destiny_child/child.dart';
import 'package:webview_windows/webview_windows.dart';

class SkinOptions extends StatelessWidget {
  final Skin skin;
  final WebviewController webviewController;

  const SkinOptions({
    super.key,
    required this.skin,
    required this.webviewController,
  });

  @override
  Widget build(BuildContext context) {
    final motions = skin.motions ?? [];
    final expressions = skin.expressions ?? [];
    return ElevatedButton(
      onPressed: () {},
      child: DropdownButton2(
        items: const [
          DropdownMenuItem(
            value: 1,
            child: Text('1'),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('1'),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('1'),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('1'),
          ),
          DropdownMenuItem(
            value: 1,
            child: Text('1'),
          ),
        ],
      ),
    );
  }
}
