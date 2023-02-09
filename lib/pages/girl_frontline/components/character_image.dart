import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/models/girl_frontline/character_model.dart';
import 'package:live2d_viewer/pages/girl_frontline/character_detail.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';
import 'package:live2d_viewer/widget/image_viewer.dart';
import 'package:provider/provider.dart';

class CharacterImage extends StatefulWidget {
  final CharacterModel character;
  const CharacterImage({
    super.key,
    required this.character,
  });

  @override
  State<StatefulWidget> createState() {
    return CharacterImageState();
  }
}

class CharacterImageState extends State<CharacterImage> {
  final http = HTTPService();

  late final CharacterModel character;

  @override
  initState() {
    super.initState();
    character = widget.character;
  }

  Future<List<File>> _loadImages() async {
    final normalImage = await http.download(character.normalImage);
    final destroyImage = await http.download(character.destroyImage);
    return [normalImage, destroyImage];
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CharacterDetailController>();
    return FutureBuilder(
      future: _loadImages(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final images = snapshot.data!;
          return ImageViewer(
            image: controller.isDestory ? images[1] : images[0],
          );
        } else if (snapshot.hasError) {
          debugPrint('${snapshot.error}');
          return ErrorDialog(message: '${snapshot.error}');
        } else {
          return const LoadingAnimation(size: 30.0);
        }
      },
    );
  }
}
