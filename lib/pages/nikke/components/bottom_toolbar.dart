import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/components/iconfont.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/nikke/character_model.dart';
import 'package:live2d_viewer/pages/nikke/components/skin_popup_menu.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:webview_windows/webview_windows.dart';

import 'components.dart';

class BottomToolbar extends StatefulWidget {
  final CharacterModel character;
  final BottomToolbarController controller;
  final WebviewController webviewController;
  final RefreshableState state;
  const BottomToolbar({
    super.key,
    required this.character,
    required this.controller,
    required this.webviewController,
    required this.state,
  });

  @override
  State<StatefulWidget> createState() {
    return _BottomToolbarState();
  }
}

class _BottomToolbarState extends State<BottomToolbar> {
  @override
  Widget build(BuildContext context) {
    final skin = widget.character.activeSkin;
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          return BottomAppBar(
            child: Toolbar(
              height: Styles.bottomAppBarHeight,
              decoration: const BoxDecoration(
                color: Styles.appBarColor,
              ),
              leadingActions: [
                PlayButton(
                  play: () {
                    widget.webviewController.executeScript('play()');
                  },
                  pause: () {
                    widget.webviewController.executeScript('pause()');
                  },
                ),
              ],
              endActions: [
                ImageButton.fromIcon(
                  icon: IconFont.iconCamera,
                  tooltip: S.of(context).tooltipSnapshot,
                  onPressed: () {
                    widget.webviewController.executeScript('snapshot()');
                  },
                ),
                if (widget.controller.visible &&
                    widget.controller.animations.length > 1)
                  AnimationPopupMenu(
                    animations: widget.controller.animations,
                    webviewController: widget.webviewController,
                  ),
                if (skin.actions.length > 1)
                  ActionPopupMenu(character: widget.character),
                if (widget.character.skins.length > 1)
                  SkinPopupMenu(character: widget.character),
                ZoomPopupControl(
                  value: 1.0,
                  max: 3.0,
                  min: 0.5,
                  webviewController: widget.webviewController,
                ),
                SpeedPlayPopupControl(
                  value: 1.0,
                  max: 2.0,
                  min: 0.5,
                  webviewController: widget.webviewController,
                ),
                ToolbarRefreshButton(widgetState: widget.state),
                WebviewConsoleButton(controller: widget.webviewController),
              ],
            ),
          );
        });
  }
}

class BottomToolbarController extends ChangeNotifier {
  List<String> animations;
  bool _visible = false;

  bool get visible => _visible;

  BottomToolbarController({required this.animations});

  setAnimations(List<String> animations) {
    this.animations = animations;
    _visible = true;
    notifyListeners();
  }
}
