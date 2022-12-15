import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/image_preview_data.dart';
import 'package:live2d_viewer/models/live2d_preview_data.dart';
import 'package:live2d_viewer/models/preview_data.dart';
import 'package:live2d_viewer/widget/preview_windows/image_preview_window.dart';
import 'package:live2d_viewer/widget/preview_windows/live2d_preview_window.dart';

class PreviewWindow extends StatelessWidget {
  final PreviewWindowController controller;
  const PreviewWindow({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Visibility(
          visible: controller.visible,
          child: Builder(
            builder: (context) {
              var data = controller.previewData.data;
              if (data is ImagePreviewData) {
                return ImagePreviewWindow(data: data);
              } else if (data is Live2DPreviewData) {
                return Live2DPreviewWindow(data: data);
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}

class PreviewWindowController extends ChangeNotifier {
  bool _visible;
  setVisible(bool visible) {
    if (_visible != visible) {
      _visible = visible;
      notifyListeners();
    }
  }

  get visible => _visible;

  PreviewData? _previewData;
  setData(PreviewData previewData) {
    _visible = true;
    if (_previewData != previewData) {
      _previewData = previewData;
      notifyListeners();
    }
  }

  get previewData => _previewData;

  hidden() {
    _visible = false;
    _previewData = PreviewData<void>();
    notifyListeners();
  }

  PreviewWindowController({bool visible = false}) : _visible = visible;
}
