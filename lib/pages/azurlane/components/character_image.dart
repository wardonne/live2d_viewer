import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/models/azurlane/character_model.dart';
import 'package:live2d_viewer/services/azurlane_service.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';
import 'package:live2d_viewer/widget/image_viewer.dart';

class CharacterImage extends StatefulWidget {
  final CharacterModel character;
  final CharacterImageController controller;
  const CharacterImage({
    super.key,
    required this.character,
    required this.controller,
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final skin = character.activeSkin;
        return FutureBuilder(
          future: skin.enableFace
              ? service.setFace(skin)
              : http.download(character.activeSkin.paintingURL),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const LoadingAnimation(size: 30);
            }
            if (snapshot.hasData) {
              return ImageViewer(image: snapshot.data!);
            } else if (snapshot.hasError) {
              debugPrint('${snapshot.error}');
              return ErrorDialog(message: '${snapshot.error}');
            } else {
              return const LoadingAnimation(size: 30);
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
