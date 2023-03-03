import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/enum/web_message.dart';
import 'package:live2d_viewer/models/nikke/character_model.dart';
import 'package:live2d_viewer/services/nikke_service.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/spine_viewer.dart';
import 'package:webview_windows/webview_windows.dart';

import 'components/components.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterDetailState();
  }
}

class CharacterDetailState extends RefreshableState<CharacterDetail> {
  final service = NikkeService();
  final BottomToolbarController _bottomToolbarController =
      BottomToolbarController(animations: []);
  bool _reload = false;

  @override
  void initState() {
    super.initState();
  }

  webMessageListener(message) {
    final event = message['event'] as String;
    final data = message['data'];
    if (WebMessage.animations.label == event) {
      final items = data['items'];
      _bottomToolbarController.setAnimations(
          (items as List<dynamic>).map((item) => item as String).toList());
    } else if (WebMessage.snapshot.label == event) {
      service.saveScreenshot(data as String);
    } else if (WebMessage.video.label == event) {
      service.saveVideo(data as String);
    }
  }

  @override
  void reload({bool forceReload = false}) {
    setState(() => _reload = forceReload);
  }

  @override
  Widget build(BuildContext context) {
    final character =
        ModalRoute.of(context)?.settings.arguments as CharacterModel;
    final action = character.activeAction;
    final WebviewController controller = WebviewController();
    controller.webMessage.listen(webMessageListener);
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: LanguageSelection(),
          )
        ],
      ),
      bottomNavigationBar: BottomToolbar(
        character: character,
        controller: _bottomToolbarController,
        webviewController: controller,
        state: this,
      ),
      body: FutureBuilder(
        future: service.loadHtml(action, reload: _reload),
        builder: (context, snapshot) {
          const loading = LoadingAnimation(size: 30.0);
          if (snapshot.connectionState != ConnectionState.done) {
            return loading;
          }
          if (snapshot.hasData) {
            final html = snapshot.data!;
            return SpineViewer(
              controller: controller,
              html: html,
              virtualHosts: [ApplicationConstants.virtualHost],
            );
          } else if (snapshot.hasError) {
            return ErrorDialog(message: snapshot.error!.toString());
          } else {
            return loading;
          }
        },
      ),
    );
  }
}
