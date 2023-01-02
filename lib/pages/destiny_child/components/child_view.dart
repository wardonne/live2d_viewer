import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/constants/settings.dart';
import 'package:live2d_viewer/models/destiny_child/child.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/models/settings/webview_settings.dart';
import 'package:live2d_viewer/pages/destiny_child/components/skin_list.dart';
import 'package:live2d_viewer/pages/destiny_child/components/skin_live2d.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/destiny_child/child_service.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/preview_windows/snapshot_preview_window.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_windows/webview_windows.dart';

// ignore: must_be_immutable
class ChildView extends StatelessWidget {
  final ChildViewController controller =
      DestinyChildConstants.childViewController;
  final SnapshotPreviewWindowController snapshotPreviewWindowController =
      SnapshotPreviewWindowController();
  late WebviewController webviewController;
  late DestinyChildSettings destinyChildSettings;
  late WebviewSettings webviewSettings;

  ChildView({super.key});

  @override
  Widget build(BuildContext context) {
    webviewController = WebviewController();
    webviewController.webMessage.listen((data) {
      getApplicationDocumentsDirectory().then((value) {
        final path =
            '${value.path}/Live2DViewer/DestinyChild/${DateTime.now().millisecondsSinceEpoch}.jpeg';
        final file = File(path);
        file.createSync(recursive: true);
        file.writeAsBytesSync(base64Decode(data));
        snapshotPreviewWindowController.setImage(path);
        Timer(const Duration(seconds: 5), () {
          snapshotPreviewWindowController.hide();
        });
      });
    });
    final settings = watchProvider<SettingsProvider>(context).settings!;
    destinyChildSettings = settings.destinyChildSettings!;
    webviewSettings = settings.webviewSettings!;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final skin = controller.selectedSkin;
        final live2dPath = destinyChildSettings.childSettings!.live2dPath;
        ChildService.loadOptions(
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
      endActions: [
        _buildSnapshotButton(),
        if (skin.motions?.isNotEmpty ?? false) _buildMotionDropdownList(),
        if (skin.expressions?.isNotEmpty ?? false)
          _buildExpressionDropdownList(),
      ],
    );
  }

  Widget _buildSnapshotButton() {
    return ImageButton(
      icon: const Icon(
        Icons.photo_camera,
        size: 20,
      ),
      onPressed: () {
        webviewController.executeScript('snapshot();');
      },
    );
  }

  Widget _buildMotionDropdownList() {
    final skin = controller.selectedSkin;
    return PopupMenuButton(
      tooltip: 'show motions',
      splashRadius: 30,
      itemBuilder: (BuildContext context) {
        return skin.motions!.map((motion) {
          return PopupMenuItem(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(motion.name),
            ),
            onTap: () async {
              await webviewController
                  .executeScript('setMotion("${motion.name}");');
            },
          );
        }).toList();
      },
      offset: const Offset(0, 38),
      child: const Icon(
        Icons.animation,
        size: 20,
      ),
    );
  }

  Widget _buildExpressionDropdownList() {
    final skin = controller.selectedSkin;
    return PopupMenuButton(
      constraints: const BoxConstraints(
        maxHeight: 400,
      ),
      splashRadius: 30,
      tooltip: 'show expressions',
      itemBuilder: (BuildContext context) {
        return skin.expressions!.map((expression) {
          return PopupMenuItem(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(expression.name),
            ),
            onTap: () async {
              await webviewController
                  .executeScript("setExpression('${expression.name}');");
            },
          );
        }).toList();
      },
      offset: const Offset(0, 38),
      child: const Icon(
        Icons.face_retouching_natural,
        size: 20,
      ),
    );
  }

  Widget _buildFootToolbar() {
    return Toolbar.footer(
      height: footerBarHeight,
      endActions: [
        ImageButton(
          icon: const Icon(Icons.refresh, size: 20),
          onPressed: () {
            webviewController.reload();
          },
        ),
        ImageButton(
          icon: const Icon(Icons.developer_board, size: 20),
          onPressed: () {
            webviewController.openDevTools();
          },
        ),
      ],
    );
  }
}

class ChildViewController extends ChangeNotifier {
  Child? data;
  int selectedIndex;

  ChildViewController({this.data, this.selectedIndex = 0});

  setData(Child data, {int? skinIndex}) {
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
