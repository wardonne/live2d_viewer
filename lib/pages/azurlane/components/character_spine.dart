import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/services/azurlane_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';
import 'package:live2d_viewer/widget/spine_viewer.dart';
import 'package:webview_windows/webview_windows.dart';

class CharacterSpine extends StatefulWidget {
  final CharacterModel character;
  final WebviewController controller;
  const CharacterSpine({
    super.key,
    required this.character,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() {
    return CharacterSpineState();
  }
}

class CharacterSpineState extends State<CharacterSpine> {
  final service = AzurlaneService();

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final spine = widget.character.activeSkin.spine!;
    const loading = LoadingAnimation(size: 30);
    return FutureBuilder(
      future: service.loadSpineHtml(spine),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return loading;
        }
        if (snapshot.hasData) {
          return SpineViewer(
            controller: controller,
            html: snapshot.data!,
            virtualHosts: [ApplicationConstants.virtualHost],
          );
        } else if (snapshot.hasError) {
          return ErrorDialog(message: '${snapshot.hasError}');
        } else {
          return loading;
        }
      },
    );
  }
}
