import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/queue_keys.dart';
import 'package:live2d_viewer/models/girl_frontline/character_model.dart';
import 'package:live2d_viewer/pages/girl_frontline/character_detail.dart';
import 'package:live2d_viewer/queue/queue.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';
import 'package:live2d_viewer/widget/image_viewer.dart';
import 'package:provider/provider.dart';

class CharacterImage extends StatefulWidget {
  final CharacterModel character;
  final bool reload;
  const CharacterImage({
    super.key,
    required this.character,
    required this.reload,
  });

  @override
  State<StatefulWidget> createState() {
    return CharacterImageState();
  }
}

class CharacterImageState extends State<CharacterImage> {
  final http = HTTPService();
  final queue = initQueue(QueueKeys.dcDetail);

  late final CharacterModel character;

  @override
  initState() {
    super.initState();
    character = widget.character;
  }

  Future<List<File>> loadImages() async {
    final normalImage = await queue.add<File>(() => http.download(
          character.normalImage,
          reload: widget.reload,
        ));
    final destroyImage = await queue.add<File>(() => http.download(
          character.destroyImage,
          reload: widget.reload,
        ));
    return [normalImage, destroyImage];
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CharacterDetailController>();
    return FutureBuilder(
      future: loadImages(),
      builder: (context, snapshot) {
        const loading = LoadingAnimation(size: 30.0);
        if (snapshot.connectionState != ConnectionState.done) {
          return loading;
        }
        if (snapshot.hasData) {
          final images = snapshot.data!;
          return ImageViewer(
            image: controller.isDestory ? images[1] : images[0],
          );
        } else if (snapshot.hasError) {
          return ErrorDialog(message: '${snapshot.error}');
        } else {
          return loading;
        }
      },
    );
  }
}
