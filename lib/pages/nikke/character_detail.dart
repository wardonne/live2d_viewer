import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/components/language_selection.dart';
import 'package:live2d_viewer/components/webview_console_button.dart';
import 'package:live2d_viewer/components/webview_refresh_button.dart';
import 'package:live2d_viewer/constants/nikke.dart';
import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/spine_html_data.dart';
import 'package:live2d_viewer/services/webview_service.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:webview_windows/webview_windows.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterDetailState();
  }
}

class CharacterDetailState extends State<CharacterDetail> {
  final WebviewController _controller = WebviewController();

  Future<String> _loadHTML() {
    return rootBundle.loadString(ResourceConstants.spineVersion40Html);
  }

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)?.settings.arguments as Character;
    debugPrint("character: $character");
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
      bottomNavigationBar: BottomAppBar(
        child: Toolbar(
          height: Styles.bottomAppBarHeight,
          decoration: const BoxDecoration(
            color: Styles.appBarColor,
          ),
          endActions: [
            WebviewRefreshButton(controller: _controller),
            WebviewConsoleButton(controller: _controller),
          ],
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _loadHTML(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final html = WebviewService.renderHtml(
                  snapshot.data!,
                  SpineHtmlData(
                    skelUrl:
                        '${NikkeConstants.assetsURL}/character/spine/${skin.code}/${action.skel}',
                    atlasUrl:
                        '${NikkeConstants.assetsURL}/character/spine/${skin.code}/${action.atlas}',
                    animation: action.animation,
                  ));
              return WebView(
                controller: _controller,
                htmlStr: html,
              );
            } else {
              return AlertDialog(
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(S.of(context).confirm),
                  ),
                ],
                icon: const Icon(Icons.warning),
              );
            }
          },
        ),
      ),
    );
  }
}
