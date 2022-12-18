import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/image_preview_data.dart';
import 'package:live2d_viewer/models/live2d_preview_data.dart';
import 'package:live2d_viewer/models/preview_data.dart';
import 'package:live2d_viewer/models/soul_carta.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
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
    var soulCartaSettings = watchProvider<SettingsProvider>(context)
        .settings!
        .destinyChildSettings!
        .soulCartaSettings!;
    return SizedBox.fromSize(
      size: const Size(80, 80),
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ImageButton.fromFile(
          filepath: '${soulCartaSettings.avatarPath}/${data.avatar}',
          onPressed: () {
            if (data.useLive2d) {
              debugPrint('live2d soul carta');
              debugPrint(soulCartaSettings.toString());
              controller.setData(PreviewData<Live2DPreviewData>(
                  data: Live2DPreviewData(
                live2dSrc: data.live2d!,
                live2dVersion: '2',
                backgroundImage: data.image,
                virtualHost: soulCartaSettings.virtualHost,
                folderPath: soulCartaSettings.path,
              )));
            } else {
              controller.setData(
                PreviewData<ImagePreviewData>(
                  data: ImagePreviewData(
                    imageSrc: '${soulCartaSettings.imagePath}/${data.image}',
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
