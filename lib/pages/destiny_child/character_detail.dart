import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/enum/web_message.dart';
import 'package:live2d_viewer/models/destiny_child/character_model.dart';
import 'package:live2d_viewer/pages/destiny_child/components/components.dart';
import 'package:live2d_viewer/services/destiny_child_service.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/live2d_viewer.dart';
import 'package:webview_windows/webview_windows.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterDetailState();
  }
}

class CharacterDetailState extends RefreshableState<CharacterDetail> {
  final _service = DestinyChildService();

  @override
  void initState() {
    super.initState();
  }

  webMessageListener(message) {
    final event = message['event'] as String;
    final data = message['data'];
    if (WebMessage.snapshot.label == event) {
      _service.saveSreenshot(data as String);
    } else if (WebMessage.video.label == event) {
      _service.saveVideo(data as String);
    }
  }

  bool _reload = false;

  @override
  void reload({bool forceReload = false}) {
    setState(() => _reload = forceReload);
  }

  @override
  Widget build(BuildContext context) {
    final DestinyChildService service = DestinyChildService();
    final character =
        ModalRoute.of(context)!.settings.arguments as CharacterModel;
    final controller = WebviewController();
    controller.webMessage.listen(webMessageListener);
    return FutureBuilder(
      future: service.loadCharacterHTML(character.activeSkin, reload: _reload),
      builder: (context, snapshot) {
        const loading = LoadingAnimation(size: 30.0);
        if (snapshot.connectionState != ConnectionState.done) {
          return loading;
        }
        if (snapshot.hasError) {
          return ErrorDialog(message: snapshot.error.toString());
        } else if (snapshot.hasData) {
          _reload = false;
          return Scaffold(
            appBar: AppBar(
              title: Text(character.activeSkin.name),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: LanguageSelection(),
                )
              ],
            ),
            bottomNavigationBar: CharacterDetailBottomToolbar(
              character: character,
              webviewController: controller,
              state: this,
            ),
            body: Live2DViewer(
              controller: controller,
              html: snapshot.data!,
              virtualHosts: [ApplicationConstants.virtualHost],
            ),
          );
        } else {
          return loading;
        }
      },
    );
  }
}
