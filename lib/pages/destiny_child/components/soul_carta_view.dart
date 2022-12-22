import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/widget/preview_windows/preview_window.dart';

class SoulCartaView extends StatelessWidget {
  final PreviewWindowController controller =
      DestinyChildConstant.soulCartaViewController;
  SoulCartaView({super.key});

  @override
  Widget build(BuildContext context) {
    return PreviewWindow(controller: controller);
  }
}
