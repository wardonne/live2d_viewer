import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/widget/buttons/slider_popup_button.dart';
import 'package:webview_windows/webview_windows.dart';

class SpeedPopupControl extends StatelessWidget {
  final double value;
  final double max;
  final double min;
  final WebviewController webviewController;

  const SpeedPopupControl({
    super.key,
    required this.value,
    required this.max,
    required this.min,
    required this.webviewController,
  });

  @override
  Widget build(BuildContext context) {
    return SliderPopupButton(
      value: value,
      max: max,
      min: min,
      offset: const Offset(0, -footerBarHeight),
      themeData: SliderTheme.of(context).copyWith(
        trackHeight: 3,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
      ),
      child: const Tooltip(
        message: 'speed play',
        child: Icon(Icons.double_arrow_rounded, size: 20),
      ),
      onChangeEnd: (value) =>
          webviewController.executeScript('speedPlay($value)'),
    );
  }
}
