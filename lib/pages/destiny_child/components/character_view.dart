import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/models/destiny_child/character.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/models/settings/webview_settings.dart';
import 'package:live2d_viewer/pages/destiny_child/components/expression_popup_menu.dart';
import 'package:live2d_viewer/pages/destiny_child/components/motion_popup_menu.dart';
import 'package:live2d_viewer/pages/destiny_child/components/skin_list.dart';
import 'package:live2d_viewer/pages/destiny_child/components/skin_live2d.dart';
import 'package:live2d_viewer/pages/destiny_child/components/zoom_popup_control.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/destiny_child/character_service.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/preview_windows/snapshot_preview_window.dart';
import 'package:live2d_viewer/widget/preview_windows/video_thumbnail_preview_window.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:path/path.dart' as p;

// ignore: must_be_immutable
class CharacterView extends StatelessWidget {
  final CharacterViewController controller =
      DestinyChildConstants.characterViewController;
  final SnapshotPreviewWindowController snapshotPreviewWindowController =
      SnapshotPreviewWindowController();
  final VideoThumbnailPreviewWindowController
      videoThumbnailPreviewWindowController =
      VideoThumbnailPreviewWindowController();
  late WebviewController webviewController;
  late DestinyChildSettings destinyChildSettings;
  late WebviewSettings webviewSettings;

  CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    webviewController = WebviewController();
    webviewController.webMessage.listen((message) {
      final event = message['event'] as String;
      final data = message['data'];
      switch (event) {
        case 'snapshot':
          getApplicationDocumentsDirectory().then((value) {
            final path = p.join(value.path, DestinyChildConstants.snapshotPath,
                '${DateTime.now().millisecondsSinceEpoch}.jpeg');
            final file = File(path);
            file.createSync(recursive: true);
            file.writeAsBytesSync(base64Decode(data));
            snapshotPreviewWindowController.setImage(path);
            Timer(const Duration(seconds: 5), () {
              snapshotPreviewWindowController.hide();
            });
          });
          break;
        case 'video':
          getApplicationDocumentsDirectory().then((value) {
            final path = p.join(value.path, DestinyChildConstants.snapshotPath,
                '${DateTime.now().millisecondsSinceEpoch}.webm');
            final file = File(path);
            file.createSync(recursive: true);
            file.writeAsBytesSync(base64Decode(data as String));
            videoThumbnailPreviewWindowController.setVideoURL(path);
            Timer(
              const Duration(seconds: 5),
              () => videoThumbnailPreviewWindowController.hide(),
            );
          });
          break;
        default:
      }
    });
    final settings = watchProvider<SettingsProvider>(context).settings!;
    destinyChildSettings = settings.destinyChildSettings!;
    webviewSettings = settings.webviewSettings!;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final skin = controller.selectedSkin;
        final live2dPath = destinyChildSettings.characterSettings!.live2dPath;
        CharacterService.loadOptions(
          skin,
          modelJson:
              '$live2dPath/${skin.live2d}/character.DRAGME.${skin.live2d}.json',
        );
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

  Widget _buildBody() {
    final skin = controller.selectedSkin;
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SkinLive2D(
            skin: skin,
            controller: webviewController,
            snapshotPreviewWindowController: snapshotPreviewWindowController,
            videoThumbnailPreviewWindowController:
                videoThumbnailPreviewWindowController,
          ),
          SkinList(skins: controller.data?.skins ?? []),
        ],
      ),
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
            DestinyChildService.openItemsWindow();
          },
        ),
      ],
      endActions: const [],
    );
  }

  Widget _buildFootToolbar() {
    final skin = controller.selectedSkin;
    return Toolbar.footer(
      height: footerBarHeight,
      endActions: [
        ImageButton(
          icon: const Icon(Icons.photo_camera, size: 20),
          onPressed: () => webviewController.executeScript('snapshot();'),
        ),
        if (skin.motions?.isNotEmpty ?? false)
          MotionPopupMenu(
            motions: skin.motions ?? [],
            webviewController: webviewController,
          ),
        if (skin.expressions?.isNotEmpty ?? false)
          ExpressionPopupMenu(
            expressions: skin.expressions ?? [],
            webviewController: webviewController,
          ),
        ZoomPopupControl(
          value: 0.6,
          max: 3.0,
          min: 0.1,
          webviewController: webviewController,
        ),
        ImageButton(
          icon: const Icon(Icons.refresh, size: 20),
          onPressed: () async => await webviewController.reload(),
        ),
        ImageButton(
          icon: const Icon(Icons.developer_board, size: 20),
          onPressed: () async => webviewController.openDevTools(),
        ),
      ],
    );
  }
}

class CharacterViewController extends ChangeNotifier {
  Character? data;
  int selectedIndex;

  CharacterViewController({this.data, this.selectedIndex = 0});

  setData(Character data, {int? skinIndex}) {
    if (this.data != data ||
        (this.data == data &&
            skinIndex != null &&
            selectedIndex != skinIndex)) {
      this.data = data;
      selectedIndex = skinIndex ?? 0;
      notifyListeners();
    }
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
