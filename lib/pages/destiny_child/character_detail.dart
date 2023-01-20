import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/destiny_child/character_model.dart';
import 'package:live2d_viewer/pages/destiny_child/components/components.dart';
import 'package:live2d_viewer/services/destiny_child_service.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/live2d_viewer.dart';
import 'package:webview_windows/webview_windows.dart';

class CharacterDetail extends StatelessWidget {
  const CharacterDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final DestinyChildService service = DestinyChildService();
    final character =
        ModalRoute.of(context)!.settings.arguments as CharacterModel;
    final webviewController = WebviewController();
    return FutureBuilder(
      future: service.loadCharacterHTML(character.activeSkin),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return ErrorDialog(message: snapshot.error.toString());
        } else if (snapshot.hasData) {
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
            bottomNavigationBar: BottomToolbar(
              character: character,
              webviewController: webviewController,
            ),
            body: Live2DViewer(
              controller: webviewController,
              html: snapshot.data!,
              virtualHosts: [ApplicationConstants.virtualHost],
            ),
          );
        } else {
          return const LoadingAnimation(size: 30.0);
        }
      },
    );
  }
}
