import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/constants/nikke.dart';
import 'package:live2d_viewer/controllers/visible_popup_menu_controller.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/settings/nikke_settings.dart';
import 'package:live2d_viewer/models/settings/webview_settings.dart';
import 'package:live2d_viewer/pages/nikke/components/action_popup_menu.dart';
import 'package:live2d_viewer/pages/nikke/components/animation_popup_menu.dart';
import 'package:live2d_viewer/pages/nikke/components/cloth_popup_menu.dart';
import 'package:live2d_viewer/pages/nikke/components/skin_list.dart';
import 'package:live2d_viewer/pages/nikke/components/skin_spine.dart';
import 'package:live2d_viewer/pages/nikke/components/speed_popup_menu.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/nikke/nikke_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/buttons/play_button.dart';
import 'package:live2d_viewer/widget/buttons/webview_console_button.dart';
import 'package:live2d_viewer/widget/buttons/webview_refresh_button.dart';
import 'package:live2d_viewer/widget/preview_windows/snapshot_preview_window.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:live2d_viewer/models/nikke/character.dart' as nikke_character;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

// ignore: must_be_immutable
class CharacterView extends StatelessWidget {
  final CharacterViewController controller =
      NikkeConstants.characterViewController;
  final SnapshotPreviewWindowController snapshotPreviewWindowController =
      SnapshotPreviewWindowController();
  late VisiblePopupMenuController<String> animationMenuController;
  late VisiblePopupMenuController<String> clothMenuController;
  late WebviewController webviewController;
  late NikkeSettings nikkeSettings;
  late WebviewSettings webviewSettings;

  CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    webviewController = WebviewController();
    webviewController.webMessage.listen((message) {
      final event = message['event'] as String;
      final data = message['data'];
      switch (event) {
        case 'animations':
          final items = data['items'];
          animationMenuController.setData(
              (items as List<dynamic>).map((item) => item as String).toList());
          break;
        case 'clothes':
          final items = data['items'];
          clothMenuController.setData(
              (items as List<dynamic>).map((item) => item as String).toList());
          break;
        case 'snapshot':
          getApplicationDocumentsDirectory().then((value) {
            final path = p.join(value.path, NikkeConstants.snapshotPath,
                '${DateTime.now().millisecondsSinceEpoch}.jpeg');
            final file = File(path);
            file.createSync(recursive: true);
            file.writeAsBytesSync(base64Decode(data as String));
            snapshotPreviewWindowController.setImage(path);
            Timer(const Duration(seconds: 5), () {
              snapshotPreviewWindowController.hide();
            });
          });
          break;
        case 'video':
          getApplicationDocumentsDirectory().then((value) {
            final path = p.join(value.path, NikkeConstants.snapshotPath,
                '${DateTime.now().millisecondsSinceEpoch}.webm');
            final file = File(path);
            file.createSync(recursive: true);
            file.writeAsBytesSync(base64Decode(data as String));
          });
          break;
        default:
      }
    });

    animationMenuController =
        VisiblePopupMenuController<String>(items: [], visible: false);
    clothMenuController = VisiblePopupMenuController(items: [], visible: false);

    final settings = watchProvider<SettingsProvider>(context).settings!;
    nikkeSettings = settings.nikkeSettings!;
    webviewSettings = settings.webviewSettings!;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeadToolbar(),
            _buildBody(),
            _buildFootToolbar(),
          ],
        );
      },
    );
  }

  Widget _buildHeadToolbar() {
    final skin = controller.selectedSkin;
    return Toolbar.header(
      height: headerBarHeight,
      title: Center(
        child: Text(skin.name),
      ),
      leadingActions: [
        ImageButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Colors.white70,
          ),
          onPressed: () {
            controller.clear();
            NikkeService.openItemsWindow();
          },
        ),
      ],
      endActions: const [],
    );
  }

  Widget _buildBody() {
    final skin = controller.selectedSkin;
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SkinSpine(
            skin: skin,
            controller: webviewController,
            snapshotPreviewWindowController: snapshotPreviewWindowController,
          ),
          SkinList(skins: controller.data?.skins ?? []),
        ],
      ),
    );
  }

  Widget _buildFootToolbar() {
    return Toolbar.footer(
      height: footerBarHeight,
      leadingActions: [
        PlayButton(
          play: () => webviewController.executeScript("play();"),
          pause: () => webviewController.executeScript("pause();"),
        ),
      ],
      endActions: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 7.5, right: 7.5),
              child: ImageButton(
                icon: const Icon(Icons.photo_camera, size: 20),
                onPressed: () async =>
                    await webviewController.executeScript('snapshot();'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7.5, right: 7.5),
              child: ImageButton(
                  icon: const Icon(Icons.video_call, size: 20),
                  onPressed: () async =>
                      await webviewController.executeScript('recordVideo();')),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7.5, right: 7.5),
              child: SpeedPopupMenu(controller: webviewController),
            ),
            AnimationPopupMenu(
              controller: animationMenuController,
              webviewController: webviewController,
              action: controller.action,
            ),
            ClothPopupMenu(
              controller: clothMenuController,
              webviewController: webviewController,
              action: controller.action,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7.5, right: 7.5),
              child: ActionPopupMenu(controller: controller),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7.5, right: 7.5),
              child: WebviewRefreshButton(controller: webviewController),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7.5, right: 7.5),
              child: WebviewConsoleButton(controller: webviewController),
            ),
          ],
        ),
      ],
    );
  }
}

class CharacterViewController extends ChangeNotifier {
  Character? data;
  int selectedIndex;
  String? actionName;

  CharacterViewController({
    this.data,
    this.selectedIndex = 0,
    this.actionName,
  });

  nikke_character.Action get action {
    return selectedSkin.actions.firstWhere(
      (element) => element.name == actionName,
      orElse: () => selectedSkin.actions.first,
    );
  }

  setData(Character data, {int? skinIndex, String? actionName}) {
    this.data = data;
    selectedIndex = skinIndex ?? 0;
    this.actionName = actionName;
    notifyListeners();
  }

  setAction(String actionName) {
    this.actionName = actionName;
    notifyListeners();
  }

  selectSkin(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      notifyListeners();
    }
  }

  clear() {
    data = null;
    selectedIndex = 0;
  }

  @override
  void dispose() {
    data = null;
    selectedIndex = 0;
    super.dispose();
  }

  Skin get selectedSkin => data!.skins[selectedIndex];
}
