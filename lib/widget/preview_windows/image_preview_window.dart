import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/image_preview_data.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:window_manager/window_manager.dart';

class ImagePreviewWindow extends StatelessWidget {
  final double maxScale = 2.0;
  final double minScale = 0.5;
  late final ImagePreviewWindowController _controller;

  final ImagePreviewData data;
  ImagePreviewWindow({super.key, required this.data}) {
    _controller =
        ImagePreviewWindowController(maxScale: maxScale, minScale: minScale);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: windowManager.getSize(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var width = snapshot.data!.width;
          var title = data.title;
          return Container(
            width: width * 0.4,
            decoration: const BoxDecoration(
              color: Colors.black26,
              border: Border(
                left: BorderSide(
                  color: Colors.white70,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                _buildHeader(title),
                _buildBody(),
                _buildFooter(),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return ErrorDialog(message: snapshot.error.toString());
        } else {
          debugPrint('empty data');
          return Container(
            width: 500,
            color: Colors.black87,
            child: const Center(
              child: Text('empty data'),
            ),
          );
        }
      },
    );
  }

  _buildHeader(String? title) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        color: Colors.black26,
        border: Border(
          bottom: BorderSide(
            color: Colors.white70,
            width: 1,
          ),
        ),
      ),
      child: title != null ? Center(child: Text(title)) : const Center(),
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
      height: 48,
      decoration: const BoxDecoration(
        color: Colors.black26,
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
    scale = _getInvalidScale(scale);
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
    scale = _getInvalidScale(scale);
    if (_scale != scale) {
      _originalScale = _scale;
      _scale = scale;
      _scaleIsChanged = true;
    } else {
      _scaleIsChanged = false;
    }
  }

  _getInvalidScale(double scale) {
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
