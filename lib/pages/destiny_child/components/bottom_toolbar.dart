import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/iconfont.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/destiny_child/character.dart';
import 'package:live2d_viewer/pages/destiny_child/components/components.dart';
import 'package:live2d_viewer/pages/destiny_child/components/motion_popup_menu.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:webview_windows/webview_windows.dart';

import 'expression_popup_menu.dart';
import 'zoom_popup_control.dart';

class BottomToolbar extends StatelessWidget {
  final Character character;
  final WebviewController webviewController;

  const BottomToolbar({
    super.key,
    required this.character,
    required this.webviewController,
  });

  @override
  Widget build(BuildContext context) {
    final skin = character.activeSkin;
    return Toolbar(
      height: Styles.bottomAppBarHeight,
      color: Styles.appBarColor,
      endActions: [
        ImageButton.fromIcon(
          icon: IconFont.iconCamera,
          tooltip: S.of(context).tooltipSnapshot,
          onPressed: () {
            webviewController.executeScript('snapshot()');
          },
        ),
        if (skin.motions!.length > 1)
          MotionPopupMenu(
            motions: skin.motions!,
            webviewController: webviewController,
          ),
        if (skin.expressions!.length > 1)
          ExpressionPopupMenu(
            expressions: skin.expressions!,
            webviewController: webviewController,
          ),
        if (character.skins.length > 1) SkinPopupMenu(character: character),
        ZoomPopupControl(
          value: 1.0,
          max: 3.0,
          min: 0.1,
          webviewController: webviewController,
        ),
        WebviewRefreshButton(controller: webviewController),
        WebviewConsoleButton(controller: webviewController),
      ],
    );
  }
}
