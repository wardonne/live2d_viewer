import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/services/nikke/nikke_service.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webview_windows/webview_windows.dart';

import 'components/components.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterDetailState();
  }
}

class CharacterDetailState extends State<CharacterDetail> {
  final service = NikkeService();
  final WebviewController _controller = WebviewController();
  final BottomToolbarController _bottomToolbarController =
      BottomToolbarController(animations: []);
  @override
  void initState() {
    super.initState();
    _controller.webMessage.listen((messages) {
      final event = messages['event'] as String;
      debugPrint(event);
      final data = messages['data'];
      switch (event) {
        case 'animations':
          final items = data['items'];
          _bottomToolbarController.setAnimations(
              (items as List<dynamic>).map((item) => item as String).toList());
          break;
        case 'snapshot':
          NikkeService().saveScreenshot(data);
          break;
        case 'video':
          NikkeService().saveVideo(data);
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)?.settings.arguments as Character;
    debugPrint('character: $character');
    final skin = character.activeSkin;
    final action = skin.activeAction;
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
        webviewController: _controller,
      ),
      body: FutureBuilder(
        future: service.loadHtml(skin, action),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final html = snapshot.data!;
            final virtualHost = VirtualHost(
              virtualHost: ApplicationConstants.localAssetsURL,
              folderPath: service.getCachePath(skin.code, action.name),
            );
            debugPrint(virtualHost.toString());
            return WebView(
              controller: _controller,
              htmlStr: html,
              virtualHosts: [virtualHost],
            );
          } else if (snapshot.hasError) {
            return ErrorDialog(message: snapshot.error!.toString());
          } else {
            final size = MediaQuery.of(context).size;
            return SizedBox(
              width: size.width,
              height: size.height,
              child: LoadingAnimationWidget.threeArchedCircle(
                color: Styles.iconColor,
                size: 30,
              ),
            );
          }
        },
      ),
    );
  }
}
