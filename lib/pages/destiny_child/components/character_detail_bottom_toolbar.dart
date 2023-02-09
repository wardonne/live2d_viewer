import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/components/snapshot_button.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/models/destiny_child/character_model.dart';
import 'package:live2d_viewer/pages/destiny_child/components/components.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:webview_windows/webview_windows.dart';

class CharacterDetailBottomToolbar extends StatelessWidget {
  final CharacterModel character;
  final WebviewController webviewController;

  const CharacterDetailBottomToolbar({
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
        SnapshotButton(webviewController: webviewController),
        if (skin.motions.length > 1)
          MotionPopupMenu(
            motions: skin.motions.map((item) => item.name).toList(),
            webviewController: webviewController,
          ),
        if (skin.expressions.length > 1)
          ExpressionPopupMenu(
            expressions: skin.expressions.map((item) => item.name).toList(),
            webviewController: webviewController,
          ),
        if (character.skins.length > 1) SkinPopupMenu(skins: character.skins),
        if (character.spring != null) SpringSkinButton(character: character),
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
