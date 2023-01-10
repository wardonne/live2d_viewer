import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoThumbnailPreviewWindow extends StatelessWidget {
  final VideoThumbnailPreviewWindowController controller;
  final double? width;
  final double? height;

  const VideoThumbnailPreviewWindow({
    super.key,
    required this.controller,
    this.width = 200,
    this.height = 150,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final player = Player(
          id: 1,
          commandlineArguments: controller.visible ? [] : ['--no-video'],
        );
        if (controller.visible) {
          player.open(
            Media.file(File(controller.videoURL!)),
            autoStart: true,
          );
        }
        return Positioned(
          width: width,
          height: height,
          right: 5,
          bottom: 5,
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) => AnimatedOpacity(
              opacity: controller.visible ? 1 : 0,
              duration: const Duration(microseconds: 500),
              child: controller.videoURL != null
                  ? Stack(
                      children: [
                        GestureDetector(
                          onTap: () async =>
                              await launchUrl(Uri.parse(controller.videoURL!)),
                          child: Video(
                            player: player,
                            showControls: false,
                          ),
                        ),
                        Positioned(
                          right: 2,
                          top: 2,
                          child: ImageButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () => controller.hide(),
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class VideoThumbnailPreviewWindowController extends ChangeNotifier {
  bool visible;
  String? videoURL;

  VideoThumbnailPreviewWindowController({this.visible = false});

  setVideoURL(String videoURL) {
    this.videoURL = videoURL;
    show();
    notifyListeners();
  }

  show() {
    if (!visible) {
      visible = true;
    }
  }

  hide() {
    if (visible) {
      visible = false;
      notifyListeners();
    }
  }
}
