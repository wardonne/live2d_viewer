import 'package:flutter/material.dart';
import 'package:live2d_viewer/enum/detail_mode.dart';
import 'package:live2d_viewer/enum/web_message.dart';
import 'package:live2d_viewer/models/girl_frontline/character_model.dart';
import 'package:live2d_viewer/models/girl_frontline/skin_model.dart';
import 'package:live2d_viewer/pages/girl_frontline/components/components.dart';
import 'package:live2d_viewer/services/girl_frontline_service.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterDetailState();
  }
}

class CharacterDetailState extends RefreshableState<CharacterDetail> {
  WebviewController? webviewController;
  BottomToolbarController? bottomToolbarController;
  final service = GirlFrontlineService();
  late CharacterModel character;
  late SkinModel skin;
  bool _reload = false;

  @override
  void reload({bool forceReload = false}) {
    setState(() => _reload = forceReload);
  }

  Widget _buildBottomToolbar(BuildContext context) {
    return BottomToolbar(
      character: character,
      webviewController: webviewController,
      bottomToolbarController: bottomToolbarController,
      state: this,
    );
  }

  Widget _buildContainer(BuildContext context) {
    final controller = context.watch<CharacterDetailController>();
    switch (controller.mode) {
      case DetailMode.image:
        return CharacterImage(character: character, reload: _reload);
      case DetailMode.spine:
      case DetailMode.spinepainting:
        return CharacterSpine(
          character: character,
          controller: webviewController!,
          reload: _reload,
        );
      case DetailMode.live2d:
        return CharacterLive2D(
          character: character,
          webviewController: webviewController!,
          bottomToolbarController: bottomToolbarController!,
          reload: _reload,
        );
    }
  }

  void webMessageListener(message) {
    final event = message['event'] as String;
    final data = message['data'];
    if (WebMessage.animations.label == event) {
      final items =
          (data['items'] as List<dynamic>).map((e) => e as String).toList();
      bottomToolbarController!.setAnimations(items);
    } else if (WebMessage.snapshot.label == event) {
      service.saveScreenshot(data as String);
    } else if (WebMessage.video.label == event) {
      service.saveVideo(data as String);
    }
  }

  @override
  Widget build(BuildContext context) {
    character = ModalRoute.of(context)!.settings.arguments as CharacterModel;
    skin = character.activeSkin;
    final defaultMode = skin.hasLive2d ? DetailMode.live2d : DetailMode.image;
    final isDestory = skin.isDestoryMode;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) {
            return CharacterDetailController(
              mode: defaultMode,
              isDestory: isDestory,
            );
          }),
        ],
        builder: (context, child) {
          if (!context.watch<CharacterDetailController>().isImage) {
            bottomToolbarController =
                BottomToolbarController(animations: [], motions: []);
            webviewController = WebviewController();
            webviewController!.webMessage.listen(webMessageListener);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(skin.name),
            ),
            bottomNavigationBar: _buildBottomToolbar(context),
            body: _buildContainer(context),
          );
        });
  }
}

class CharacterDetailController extends ChangeNotifier {
  DetailMode _mode;
  bool _isDestory;
  bool _isRest;
  CharacterDetailController({
    required DetailMode mode,
    required bool isDestory,
    bool isRest = false,
  })  : _mode = mode,
        _isDestory = isDestory,
        _isRest = isRest;

  DetailMode get mode => _mode;

  set mode(DetailMode mode) {
    if (_mode != mode) {
      _mode = mode;
      notifyListeners();
    }
  }

  bool get isImage => _mode == DetailMode.image;

  bool get isLive2D => _mode == DetailMode.live2d;

  bool get isSpine => _mode == DetailMode.spine;

  bool get isDestory => _isDestory;

  set isDestory(bool isDestory) {
    if (_isDestory != isDestory) {
      _isDestory = isDestory;
      notifyListeners();
    }
  }

  bool get isRest => _isRest;

  set isRest(bool isRest) {
    if (_isRest != isRest) {
      _isRest = isRest;
      notifyListeners();
    }
  }
}
