import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/preview_data/image_preview_data.dart';

class ImagePreviewWindow extends StatelessWidget {
  final double maxScale;
  final double minScale;
  final ImagePreviewWindowController controller;

  final ImagePreviewData data;
  const ImagePreviewWindow({
    super.key,
    required this.data,
    required this.maxScale,
    required this.minScale,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return ClipRect(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ExtendedImage.file(
              File(data.imageSrc),
              mode: ExtendedImageMode.gesture,
              fit: BoxFit.contain,
              width: double.infinity,
              filterQuality: FilterQuality.high,
              initGestureConfigHandler: (state) {
                var initScale = controller.scale;
                if (controller.scaleIsChanged) {
                  clearGestureDetailsCache();
                }
                return GestureConfig(
                  minScale: minScale,
                  maxScale: maxScale,
                  initialScale: initScale,
                  cacheGesture: true,
                  inPageView: false,
                  gestureDetailsIsChanged: (details) {
                    controller.changeScale(details!.totalScale!);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ImagePreviewWindowController extends ChangeNotifier {
  final double maxScale;
  final double minScale;

  ImagePreviewWindowController({
    required this.maxScale,
    required this.minScale,
  });

  double _originalScale = 1.0;
  double _scale = 1.0;
  bool _scaleIsChanged = false;
  setScale(double scale) {
    scale = _getValidScale(scale);
    if (_scale != scale) {
      _originalScale = _scale;
      _scale = scale;
      _scaleIsChanged = true;
      notifyListeners();
    } else {
      _scaleIsChanged = false;
    }
  }

  changeScale(double scale) {
    scale = _getValidScale(scale);
    if (_scale != scale) {
      _originalScale = _scale;
      _scale = scale;
      _scaleIsChanged = true;
    } else {
      _scaleIsChanged = false;
    }
  }

  zoomIn() {
    setScale(_scale + 0.1);
  }

  zoomOut() {
    setScale(_scale - 0.1);
  }

  double _getValidScale(double scale) {
    if (scale >= maxScale) {
      scale = maxScale;
    } else if (scale <= minScale) {
      scale = minScale;
    }
    return scale;
  }

  double get scale => _scale;
  double get originalScale => _originalScale;
  bool get scaleIsChanged => _scaleIsChanged;
}
