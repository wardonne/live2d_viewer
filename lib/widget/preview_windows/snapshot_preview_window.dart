import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SnapshotPreviewWindow extends StatelessWidget {
  final SnapshotPreviewWindowController controller;
  final double? width;
  final double? height;

  const SnapshotPreviewWindow({
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
          return Positioned(
            width: width,
            height: height,
            right: 5,
            bottom: 2,
            child: _buildImage(),
          );
        });
  }

  Widget _buildImage() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => AnimatedOpacity(
        opacity: controller.visible ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: controller.path != null
            ? Container(
                child: Stack(
                  children: [
                    ImageButton.fromFile(
                      filepath: controller.path!,
                      onPressed: () async {
                        final uri = Uri.parse(controller.path!);
                        launchUrl(uri);
                      },
                    ),
                    Positioned(
                      right: 2,
                      top: 2,
                      child: ImageButton.fromIcon(
                        icon: Icons.close,
                        onPressed: () {
                          controller.hide();
                        },
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

class SnapshotPreviewWindowController extends ChangeNotifier {
  bool visible;
  String? path;

  SnapshotPreviewWindowController({this.visible = false});

  setImage(String path) {
    this.path = path;
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
