import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/constants/settings.dart';
import 'package:live2d_viewer/models/preview_data/image_preview_data.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/preview_windows/preview_window.dart';
import 'package:live2d_viewer/widget/toolbar.dart';

class ImagePreviewWindow extends StatelessWidget {
  final double maxScale = 2.0;
  final double minScale = 0.5;
  final PreviewWindowController previewWindowController =
      DestinyChildConstant.soulCartaViewController;
  late final ImagePreviewWindowController _controller;

  final ImagePreviewData data;
  ImagePreviewWindow({super.key, required this.data}) {
    _controller =
        ImagePreviewWindowController(maxScale: maxScale, minScale: minScale);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: barColor,
      child: Column(
        children: [
          _buildHeader(data.title),
          _buildBody(),
          _buildFooter(),
        ],
      ),
    );
  }

  _buildHeader(String? title) {
    return Toolbar.header(
      height: headerBarHeight,
      title: Center(
        child: Text(title ?? ''),
      ),
      leadingActions: [
        ImageButton.fromIcon(
            icon: Icons.arrow_forward_ios,
            onPressed: () {
              previewWindowController.clear();
              DestinyChildService.openItemsWindow();
            }),
      ],
    );
  }

  _buildBody() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _bodyContent();
      },
    );
  }

  _bodyContent() {
    return Expanded(
      child: ClipRect(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ExtendedImage.file(
            File(data.imageSrc),
            mode: ExtendedImageMode.gesture,
            fit: BoxFit.contain,
            width: double.infinity,
            filterQuality: FilterQuality.high,
            initGestureConfigHandler: (state) {
              var initScale = _controller.scale;
              if (_controller.scaleIsChanged) {
                clearGestureDetailsCache();
              }
              return GestureConfig(
                minScale: minScale,
                maxScale: maxScale,
                initialScale: initScale,
                cacheGesture: true,
                inPageView: false,
                gestureDetailsIsChanged: (details) {
                  _controller.changeScale(details!.totalScale!);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  _buildFooter() {
    return Container(
      height: footerBarHeight,
      decoration: const BoxDecoration(
        color: barColor,
        border: Border(top: BorderSide(color: Colors.white70)),
      ),
      child: Row(
        children: [
          Expanded(child: Container()),
          ButtonBar(
            children: [
              IconButton(
                onPressed: () {
                  _controller.setScale(_controller.scale + 0.1);
                },
                icon: const Icon(Icons.zoom_in),
              ),
              IconButton(
                onPressed: () {
                  _controller.setScale(_controller.scale - 0.1);
                },
                icon: const Icon(Icons.zoom_out),
              ),
            ],
          ),
        ],
      ),
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

  _getValidScale(double scale) {
    if (scale >= maxScale) {
      scale = maxScale;
    } else if (scale <= minScale) {
      scale = minScale;
    }
    return scale;
  }

  get scale => _scale;
  get originalScale => _originalScale;
  get scaleIsChanged => _scaleIsChanged;
}
