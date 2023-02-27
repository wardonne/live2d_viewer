import 'package:flutter/material.dart';
import 'package:live2d_viewer/enum/detail_mode.dart';
import 'package:live2d_viewer/enum/web_message.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/pages/azurlane/components/character_spine_painting.dart';
import 'package:live2d_viewer/pages/azurlane/components/components.dart';
import 'package:live2d_viewer/services/azurlane_service.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterDetailState();
  }
}

class CharacterDetailState extends State<CharacterDetail> {
  final service = AzurlaneService();
  WebviewController? webviewController;
  BottomToolbarController? bottomToolbarController;
  CharacterImageController? characterImageController;

  late final CharacterModel character;
  late final SkinModel skin;

  Widget _buildBottomToolbar(BuildContext context) {
    return BottomToolbar(
      character: character,
      webviewController: webviewController,
      bottomToolbarController: bottomToolbarController,
      characterImageController: characterImageController,
    );
  }

  Widget _buildContainer(BuildContext context) {
    final controller = context.watch<CharacterDetailController>();
    switch (controller.mode) {
      case DetailMode.image:
        return CharacterImage(
          character: character,
          controller: characterImageController!,
        );
      case DetailMode.spine:
        return CharacterSpine(
          character: character,
          controller: webviewController!,
        );
      case DetailMode.spinepainting:
        return CharacterSpinePainting(
          character: character,
          controller: webviewController!,
        );
      case DetailMode.live2d:
        return CharacterLive2D(
          character: character,
          webviewController: webviewController!,
          bottomToolbarController: bottomToolbarController!,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    character = ModalRoute.of(context)!.settings.arguments as CharacterModel;
    skin = character.activeSkin;
    final defaultMode = skin.hasLive2d
        ? DetailMode.live2d
        : (skin.hasSpinePainting ? DetailMode.spinepainting : DetailMode.image);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return CharacterDetailController(mode: defaultMode);
        }),
      ],
      builder: (context, child) {
        if (!context.watch<CharacterDetailController>().isImage) {
          bottomToolbarController =
              BottomToolbarController(animations: [], motions: []);
          webviewController = WebviewController();
          webviewController!.webMessage.listen((message) {
            final event = message['event'] as String;
            final data = message['data'];
            if (WebMessage.animations.label == event) {
              final items = (data['items'] as List<dynamic>)
                  .map((e) => e as String)
                  .toList();
              bottomToolbarController!.animations = items;
            } else if (WebMessage.snapshot.label == event) {
              service.saveScreenshot(data as String);
            } else if (WebMessage.video.label == event) {
              service.saveVideo(data as String);
            }
          });
        } else {
          characterImageController = CharacterImageController(0);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(skin.name),
          ),
          bottomNavigationBar: _buildBottomToolbar(context),
          body: _buildContainer(context),
        );
      },
    );
  }
}

class CharacterDetailController extends ChangeNotifier {
  DetailMode _mode;
  CharacterDetailController({required DetailMode mode}) : _mode = mode;

  DetailMode get mode => _mode;

  set mode(DetailMode mode) {
    if (_mode != mode) {
      _mode = mode;
      notifyListeners();
    }
  }

  bool get isImage => _mode == DetailMode.image;

  bool get isSpine => _mode == DetailMode.spine;

  bool get isLive2D => _mode == DetailMode.live2d;
}
