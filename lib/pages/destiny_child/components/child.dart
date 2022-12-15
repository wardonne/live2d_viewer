import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/live2d_preview_data.dart';
import 'package:live2d_viewer/models/preview_data.dart';
import 'package:live2d_viewer/widget/preview_windows/preview_window.dart';

class ChildTabView extends StatelessWidget {
  final PreviewWindowController controller;
  const ChildTabView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          controller.setData(PreviewData<Live2DPreviewData>(
              data: Live2DPreviewData(live2dSrc: '', live2dVersion: 2)));
        },
        child: const Text(
          'Child',
          textScaleFactor: 2,
        ),
      ),
    );
  }
}
