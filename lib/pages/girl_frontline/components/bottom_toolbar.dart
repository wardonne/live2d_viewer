import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/components/iconfont.dart';
import 'package:live2d_viewer/components/snapshot_button.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/enum/detail_mode.dart';
import 'package:live2d_viewer/models/girl_frontline/character_model.dart';
import 'package:live2d_viewer/models/girl_frontline/skin_model.dart';
import 'package:live2d_viewer/pages/girl_frontline/character_detail.dart';
import 'package:live2d_viewer/pages/girl_frontline/components/components.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

class BottomToolbar extends StatefulWidget {
  final CharacterModel character;
  final WebviewController? webviewController;
  final BottomToolbarController? bottomToolbarController;
  const BottomToolbar({
    super.key,
    required this.character,
    this.webviewController,
    this.bottomToolbarController,
  });

  @override
  State<StatefulWidget> createState() {
    return BottomToolbarState();
  }
}

class BottomToolbarState extends State<BottomToolbar> {
  late final CharacterModel character;
  late final SkinModel skin;

  @override
  void initState() {
    super.initState();
    character = widget.character;
    skin = character.activeSkin;
  }

  Widget _buildAppBar(
    CharacterDetailController controller,
    BottomToolbarController? toolbarController,
  ) {
    return BottomAppBar(
      child: Toolbar(
        height: Styles.bottomAppBarHeight,
        decoration: const BoxDecoration(color: Styles.appBarColor),
        endActions: [
          if (!controller.isSpine && character.activeSkin.spine != null) ...[
            ImageButton(
              icon: Image.asset(
                ResourceConstants.girlFrontlineAnimatedFilterLogo,
                width: 20.0,
              ),
              onPressed: () => controller.mode = DetailMode.spine,
            ),
          ],
          if (!controller.isSpine)
            ImageButton(
              icon: Icon(
                controller.isDestory ? IconFont.iconHeart : Icons.heart_broken,
              ),
              onPressed: () => controller.isDestory = !controller.isDestory,
            ),
          if (character.skins.length > 1) SkinPopupMenu(skins: character.skins),
          if (controller.isSpine) ...[
            ImageButton(
              icon: const Icon(Icons.home),
              onPressed: () => controller.isRest = !controller.isRest,
            ),
            if (toolbarController!.animations.length > 1)
              AnimationPopupMenu(
                animations: toolbarController.animations,
                webviewController: widget.webviewController!,
              ),
          ],
          if (controller.isLive2D && skin.motions.length > 1)
            MotionPopupMenu(
              motions: skin.motions.map((e) => e.name).toList(),
              webviewController: widget.webviewController!,
            ),
          if (!controller.isLive2D && character.activeSkin.hasLive2d)
            ImageButton(
              icon: Image.asset(
                ResourceConstants.girlFrontlineLive2DFilterLogo,
                width: 20.0,
              ),
              onPressed: () => controller.mode = DetailMode.live2d,
            ),
          if (!controller.isImage) ...[
            SnapshotButton(webviewController: widget.webviewController!),
            ZoomPopupControl(
              value: 1.0,
              max: 3.0,
              min: 0.5,
              webviewController: widget.webviewController!,
            ),
            ImageButton(
              icon: Image.asset(
                ResourceConstants.girlFrontlineImageFilterLogo,
                width: 20.0,
              ),
              onPressed: () => controller.mode = DetailMode.image,
            ),
            WebviewRefreshButton(controller: widget.webviewController!),
            WebviewConsoleButton(controller: widget.webviewController!),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CharacterDetailController>();
    return controller.isSpine
        ? AnimatedBuilder(
            animation: widget.bottomToolbarController!,
            builder: (context, _) {
              return _buildAppBar(controller, widget.bottomToolbarController);
            })
        : _buildAppBar(controller, widget.bottomToolbarController);
  }
}

class BottomToolbarController extends ChangeNotifier {
  List<String> _animations;
  BottomToolbarController({
    required List<String> animations,
  }) : _animations = animations;

  List<String> get animations => _animations;

  set animations(List<String> value) {
    if (_animations != value) {
      _animations = value;
      notifyListeners();
    }
  }
}
