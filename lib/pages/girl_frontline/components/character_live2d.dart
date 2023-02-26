import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/models/girl_frontline/character_model.dart';
import 'package:live2d_viewer/models/girl_frontline/skin_model.dart';
import 'package:live2d_viewer/pages/girl_frontline/character_detail.dart';
import 'package:live2d_viewer/pages/girl_frontline/components/components.dart';
import 'package:live2d_viewer/services/girl_frontline_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';
import 'package:live2d_viewer/widget/live2d_viewer.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

class CharacterLive2D extends StatefulWidget {
  final CharacterModel character;
  final WebviewController webviewController;
  final BottomToolbarController bottomToolbarController;
  const CharacterLive2D({
    super.key,
    required this.character,
    required this.webviewController,
    required this.bottomToolbarController,
  });

  @override
  State<StatefulWidget> createState() {
    return CharacterLive2DState();
  }
}

class CharacterLive2DState extends State<CharacterLive2D> {
  final service = GirlFrontlineService();
  late final CharacterModel character;
  late final SkinModel skin;
  late WebviewController controller;

  @override
  void initState() {
    super.initState();
    character = widget.character;
    skin = character.activeSkin;
  }

  @override
  Widget build(BuildContext context) {
    controller = widget.webviewController;
    final isDestory = context.watch<CharacterDetailController>().isDestory;
    return FutureBuilder(
      future: service.loadLive2DHtml(skin.live2d!, isDestory: isDestory),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingAnimation(size: 30.0);
        }
        if (snapshot.hasData) {
          final html = snapshot.data!;
          Future.delayed(const Duration(seconds: 1), () {
            widget.bottomToolbarController
                .setMotions(skin.motions.map((e) => e.name).toList());
          });
          return Live2DViewer(
            controller: controller,
            html: html,
            virtualHosts: [ApplicationConstants.virtualHost],
          );
        } else if (snapshot.hasError) {
          return ErrorDialog(message: '${snapshot.error}');
        } else {
          return const LoadingAnimation(size: 30.0);
        }
      },
    );
  }
}
