import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/constants/settings.dart';
import 'package:live2d_viewer/models/destiny_child/soul_carta.dart';
import 'package:live2d_viewer/models/live2d_html_data.dart';
import 'package:live2d_viewer/models/preview_data/image_preview_data.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/models/settings/webview_settings.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/services/destiny_child/soul_carta_service.dart';
import 'package:live2d_viewer/services/webview_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/preview_windows/image_preview_window.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

// ignore: must_be_immutable
class SoulCartaView extends StatelessWidget {
  static const maxScale = 3.0;
  static const minScale = 0.5;
  final SoulCartaViewController controller =
      DestinyChildConstants.soulCartaViewController;
  final ImagePreviewWindowController imagePreviewWindowController =
      ImagePreviewWindowController(maxScale: maxScale, minScale: minScale);
  late WebviewController webviewController;
  late DestinyChildSettings destinyChildSettings;
  late WebviewSettings webviewSettings;

  SoulCartaView({super.key});

  @override
  Widget build(BuildContext context) {
    webviewController = WebviewController();
    final settings = watchProvider<SettingsProvider>(context).settings!;
    destinyChildSettings = settings.destinyChildSettings!;
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
    final data = controller.data!;
    return Toolbar.header(
      height: headerBarHeight,
      color: barColor,
      title: Center(
        child: Text(data.name ?? data.avatar),
      ),
      leadingActions: [
        ImageButton(
          icon: const Icon(
            Icons.arrow_forward_ios,
            size: 20,
            color: Colors.white70,
          ),
          onPressed: () {
            DestinyChildService.openItemsWindow();
            SoulCartaService.clearViewWindow();
          },
        )
      ],
    );
  }

  Widget _buildBody() {
    final data = controller.data!;

    final live2dHost = destinyChildSettings.soulCartaSettings!.live2dHost;
    final live2dModel = 'character.DRAGME.${data.live2d}.json';
    final imageHost = destinyChildSettings.soulCartaSettings!.imageHost;
    if (data.useLive2d) {
      final viewModel = Live2DHtmlData(
        live2d: '$live2dHost/${data.live2d}/$live2dModel',
        webviewHost: webviewSettings.virtualHost,
        backgroundImage: '$imageHost/${data.image}',
        canSetExpression: false,
        canSetMotion: false,
      );
      return Expanded(
        child: FutureProvider<String>(
          create: (context) => rootBundle.loadString(live2dVersion2Html),
          initialData: '',
          child: Consumer<String>(
            builder: (context, data, child) {
              final host = destinyChildSettings.soulCartaSettings!.virtualHost!;
              final path = destinyChildSettings.soulCartaSettings!.path!;
              return WebView(
                htmlStr: WebviewService.renderHtml(data, viewModel),
                controller: webviewController,
                virtualHosts: [
                  VirtualHost(
                    virtualHost: webviewSettings.virtualHost!,
                    folderPath: webviewSettings.path!,
                  ),
                  VirtualHost(virtualHost: host, folderPath: path),
                ],
              );
            },
          ),
        ),
      );
    } else {
      final imagePath = destinyChildSettings.soulCartaSettings!.imagePath;
      return Expanded(
        child: ImagePreviewWindow(
          data: ImagePreviewData(
            imageSrc: '$imagePath/${data.image}',
            title: data.name ?? data.avatar,
          ),
          maxScale: maxScale,
          minScale: minScale,
          controller: imagePreviewWindowController,
        ),
      );
    }
  }

  Widget _buildFootToolbar() {
    final data = controller.data!;
    List<Widget> endActions = [];
    if (data.useLive2d) {
      endActions.add(ImageButton(
        icon: const Icon(Icons.refresh, size: 20, color: Colors.white70),
        onPressed: () {
          webviewController.reload();
        },
      ));
      endActions.add(ImageButton(
        icon:
            const Icon(Icons.developer_board, size: 20, color: Colors.white70),
        onPressed: () {
          webviewController.openDevTools();
        },
      ));
    } else {
      endActions.add(ImageButton(
        icon: const Icon(Icons.zoom_in, color: Colors.white70, size: 20),
        onPressed: () {
          imagePreviewWindowController.zoomIn();
        },
      ));
      endActions.add(ImageButton(
        icon: const Icon(Icons.zoom_out, color: Colors.white70, size: 20),
        onPressed: () {
          imagePreviewWindowController.zoomOut();
        },
      ));
    }
    return Toolbar.footer(
      height: footerBarHeight,
      color: barColor,
      endActions: endActions,
    );
  }
}

class SoulCartaViewController extends ChangeNotifier {
  SoulCarta? data;
  SoulCartaViewController({this.data});

  setData(SoulCarta data) {
    if (this.data != data) {
      this.data = data;
      notifyListeners();
    }
  }

  clear() {
    data = null;
  }
}
