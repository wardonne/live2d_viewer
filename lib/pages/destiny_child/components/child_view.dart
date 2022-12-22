import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/constants/settings.dart';
import 'package:live2d_viewer/models/destiny_child/child.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/models/settings/webview_settings.dart';
import 'package:live2d_viewer/pages/destiny_child/components/skin_list.dart';
import 'package:live2d_viewer/pages/destiny_child/components/skin_live2d.dart';
import 'package:live2d_viewer/pages/destiny_child/components/skin_options.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/destiny_child/child_service.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/preview_windows/preview_window.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:webview_windows/webview_windows.dart';

class ChildView extends StatelessWidget {
  final ChildViewController controller =
      DestinyChildConstant.childViewController;
  final PreviewWindowController previewWindowController =
      PreviewWindowController();
  late WebviewController webviewController;
  late DestinyChildSettings destinyChildSettings;
  late WebviewSettings webviewSettings;

  ChildView({super.key});

  @override
  Widget build(BuildContext context) {
    webviewController = WebviewController();
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
          SkinList(skins: controller.data?.skins ?? []),
          SkinLive2D(skin: skin, controller: webviewController),
          SkinOptions(skin: skin, webviewController: webviewController),
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
    );
  }

  Widget _buildFootToolbar() {
    return Toolbar.footer(
      height: footerBarHeight,
      endActions: [
        ImageButton.fromIcon(
          icon: Icons.refresh,
          onPressed: () {
            webviewController.reload();
          },
        ),
        ImageButton.fromIcon(
          icon: Icons.developer_board,
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

  setData(Child data) {
    if (this.data != data) {
      this.data = data;
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
