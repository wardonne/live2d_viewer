import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/pages/azurlane/components/components.dart';
import 'package:live2d_viewer/services/azurlane_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';
import 'package:live2d_viewer/widget/live2d_viewer.dart';
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
  final service = AzurlaneService();

  late final CharacterModel character;
  late final SkinModel skin;
  late WebviewController controller;

  @override
  void initState() {
    super.initState();
    character = widget.character;
    skin = character.activeSkin;
    controller = widget.webviewController;
  }

  @override
  Widget build(BuildContext context) {
    const loading = LoadingAnimation(size: 30.0);
    return FutureBuilder(
      future: service.loadLive2DHtml(skin),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return loading;
        }
        if (snapshot.hasData) {
          Future.delayed(const Duration(seconds: 1), () {
            widget.bottomToolbarController.motions =
                skin.motions.map((e) => e.name).toList();
          });
          return Live2DViewer(
            controller: controller,
            html: snapshot.data!,
            virtualHosts: [ApplicationConstants.virtualHost],
          );
        } else if (snapshot.hasError) {
          debugPrint('${snapshot.error}');
          return ErrorDialog(message: '${snapshot.error}');
        } else {
          return loading;
        }
      },
    );
  }
}
