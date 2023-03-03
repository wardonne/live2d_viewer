import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/queue/queue.dart';
import 'package:live2d_viewer/services/azurlane_service.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';
import 'package:live2d_viewer/widget/image_viewer.dart';

class CharacterImage extends StatefulWidget {
  final CharacterModel character;
  final CharacterImageController controller;
  final bool reload;
  const CharacterImage({
    super.key,
    required this.character,
    required this.controller,
    required this.reload,
  });

  @override
  State<StatefulWidget> createState() {
    return CharacterImageState();
  }
}

class CharacterImageState extends State<CharacterImage> {
  final http = HTTPService();
  final service = AzurlaneService();

  late final CharacterModel character;

  @override
  void initState() {
    super.initState();
    character = widget.character;
  }

  Future<File> loadImage(SkinModel skin) {
    return initQueue(QueueKeys.alDetail).add<File>(() => skin.enableFace
        ? service.setFace(skin, reload: widget.reload)
        : http.download(skin.paintingURL, reload: widget.reload));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final skin = character.activeSkin;
        return FutureBuilder(
          future: loadImage(skin),
          builder: (context, snapshot) {
            const loading = LoadingAnimation(size: 30);
            if (snapshot.connectionState != ConnectionState.done) {
              return loading;
            }
            if (snapshot.hasData) {
              return ImageViewer(image: snapshot.data!);
            } else if (snapshot.hasError) {
              debugPrint('${snapshot.error}');
              return ErrorDialog(message: '${snapshot.error}');
            } else {
              return loading;
            }
          },
        );
      },
    );
  }
}

class CharacterImageController extends ValueNotifier<int> {
  CharacterImageController(super.value);
}
