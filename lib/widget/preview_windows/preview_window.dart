import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/preview_data/image_preview_data.dart';
import 'package:live2d_viewer/models/preview_data/live2d_preview_data.dart';
import 'package:live2d_viewer/models/preview_data/preview_data.dart';
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
        var data = controller.previewData.data;
        if (data is ImagePreviewData) {
          return ImagePreviewWindow(data: data);
        } else if (data is Live2DPreviewData) {
          return Live2DPreviewWindow(data: data);
        } else {
          return Container();
        }
      },
    );
  }
}

class PreviewWindowController extends ChangeNotifier {
  PreviewData? _previewData;
  setData(PreviewData previewData) {
    if (_previewData != previewData) {
      _previewData = previewData;
      notifyListeners();
    }
  }

  get previewData => _previewData;

  clear() {
    _previewData = PreviewData<void>();
    notifyListeners();
  }

  PreviewWindowController();
}
