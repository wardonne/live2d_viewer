import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/components/iconfont.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/nikke/character_model.dart';
import 'package:live2d_viewer/pages/nikke/components/skin_popup_menu.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:webview_windows/webview_windows.dart';

import 'components.dart';

class BottomToolbar extends StatefulWidget {
  final CharacterModel character;
  final BottomToolbarController _controller;
  final WebviewController _webviewController;
  const BottomToolbar({
    super.key,
    required this.character,
    required BottomToolbarController controller,
    required WebviewController webviewController,
  })  : _controller = controller,
        _webviewController = webviewController;

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
        animation: widget._controller,
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
                    widget._webviewController.executeScript('play()');
                  },
                  pause: () {
                    widget._webviewController.executeScript('pause()');
                  },
                ),
              ],
              endActions: [
                ImageButton.fromIcon(
                  icon: IconFont.iconCamera,
                  tooltip: S.of(context).tooltipSnapshot,
                  onPressed: () {
                    widget._webviewController.executeScript('snapshot()');
                  },
                ),
                if (widget._controller.visible &&
                    widget._controller.animations.length > 1)
                  AnimationPopupMenu(
                    animations: widget._controller.animations,
                    webviewController: widget._webviewController,
                  ),
                if (skin.actions.length > 1)
                  ActionPopupMenu(character: widget.character),
                if (widget.character.skins.length > 1)
                  SkinPopupMenu(character: widget.character),
                ZoomPopupControl(
                  value: 1.0,
                  max: 3.0,
                  min: 0.5,
                  webviewController: widget._webviewController,
                ),
                SpeedPopupControl(
                  value: 1.0,
                  max: 2.0,
                  min: 0.5,
                  webviewController: widget._webviewController,
                ),
                WebviewRefreshButton(controller: widget._webviewController),
                WebviewConsoleButton(controller: widget._webviewController),
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
