import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/components/iconfont.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:webview_windows/webview_windows.dart';

class SnapshotButton extends StatelessWidget {
  final WebviewController webviewController;
  const SnapshotButton({
    super.key,
    required this.webviewController,
  });

  @override
  Widget build(BuildContext context) {
    return ImageButton.fromIcon(
      icon: IconFont.iconCamera,
      tooltip: S.of(context).tooltipSnapshot,
      onPressed: () {
        webviewController.executeScript('snapshot()');
      },
    );
  }
}
