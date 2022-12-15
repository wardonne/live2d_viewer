import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/image_preview_data.dart';
import 'package:live2d_viewer/models/live2d_preview_data.dart';
import 'package:live2d_viewer/models/preview_data.dart';
import 'package:live2d_viewer/models/soul_carta.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/preview_windows/preview_window.dart';

class SoulCartaItem extends StatelessWidget {
  final SoulCarta data;
  final PreviewWindowController controller;
  const SoulCartaItem({
    super.key,
    required this.data,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(80, 80),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ImageButton.fromFile(
          filepath: data.avatarPath,
          onPressed: () {
            if (data.useLive2d) {
              debugPrint('live2d soul carta');
              controller.setData(PreviewData<Live2DPreviewData>(
                  data: Live2DPreviewData(
                live2dSrc: '',
                live2dVersion: 2,
              )));
            } else {
              controller.setData(
                PreviewData<ImagePreviewData>(
                  data: ImagePreviewData(
                    imageSrc: data.imagePath,
                    title: data.avatar,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
