import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/enum/detail_mode.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/pages/azurlane/azurlane.dart';
import 'package:live2d_viewer/pages/azurlane/components/components.dart';
import 'package:live2d_viewer/pages/azurlane/components/face_popup_menu.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

class BottomToolbar extends StatefulWidget {
  final CharacterModel character;
  final WebviewController? webviewController;
  final BottomToolbarController? bottomToolbarController;
  final CharacterImageController? characterImageController;
  const BottomToolbar({
    super.key,
    this.webviewController,
    this.bottomToolbarController,
    this.characterImageController,
    required this.character,
  });

  @override
  State<StatefulWidget> createState() {
    return BottomToolbarState();
  }
}

class BottomToolbarState extends State<BottomToolbar> {
  late CharacterModel character;
  late SkinModel skin;

  Widget _buildAppbar(
    CharacterDetailController controller,
    BottomToolbarController? toolbarController,
  ) {
    return BottomAppBar(
      child: Toolbar(
        height: Styles.bottomAppBarHeight,
        decoration: const BoxDecoration(color: Styles.appBarColor),
        endActions: [
          if (!controller.isSpine && character.activeSkin.spine != null)
            ImageButton(
              icon: Image.asset(
                ResourceConstants.spineIcon,
                width: 20,
              ),
              tooltip: S.of(context).tooltipSD,
              onPressed: () => controller.mode = DetailMode.spine,
            ),
          if (character.skins.length > 1) SkinPopupMenu(skins: character.skins),
          if (controller.isSpine && toolbarController!.animations.length > 1)
            AnimationPopupMenu(
              webviewController: widget.webviewController!,
              animations: toolbarController.animations,
            ),
          if (controller.isLive2D && toolbarController!.motions.length > 1)
            MotionPopupMenu(
              motions: toolbarController.motions,
              webviewController: widget.webviewController!,
            ),
          if (!controller.isLive2D && skin.hasLive2d)
            ImageButton(
              icon: Image.asset(
                ResourceConstants.azurlaneTypeLive2D,
                width: 20.0,
              ),
              tooltip: S.of(context).tooltipLive2D,
              onPressed: () => controller.mode = DetailMode.live2d,
            ),
          if (!controller.isImage) ...[
            SnapshotButton(webviewController: widget.webviewController!),
            WebviewRefreshButton(controller: widget.webviewController!),
            WebviewConsoleButton(controller: widget.webviewController!),
          ],
          if (controller.isImage &&
              skin.faces != null &&
              skin.faces!.length > 1)
            FacePopupMenu(
              skin: skin,
              controller: widget.characterImageController!,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CharacterDetailController>();
    character = widget.character;
    skin = character.activeSkin;
    final toolbarController = widget.bottomToolbarController;
    return !controller.isImage
        ? AnimatedBuilder(
            animation: toolbarController!,
            builder: (context, _) => _buildAppbar(
              controller,
              toolbarController,
            ),
          )
        : _buildAppbar(
            controller,
            toolbarController,
          );
  }
}

class BottomToolbarController extends ChangeNotifier {
  List<String> _animations;
  List<String> _motions;

  BottomToolbarController({
    required List<String> animations,
    required List<String> motions,
  })  : _animations = animations,
        _motions = motions;

  List<String> get animations => _animations;

  set animations(List<String> value) {
    if (_animations != value) {
      _animations = value;
      notifyListeners();
    }
  }

  List<String> get motions => _motions;

  set motions(List<String> value) {
    if (_motions != value) {
      _motions = value;
      notifyListeners();
    }
  }
}
