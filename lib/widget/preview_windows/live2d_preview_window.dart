import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/constants/settings.dart';
import 'package:live2d_viewer/models/preview_data/live2d_preview_data.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/utils/render.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:webview_windows/webview_windows.dart';

class Live2DPreviewWindow extends StatelessWidget {
  final Live2DPreviewData data;

  Live2DPreviewWindow({
    super.key,
    required this.data,
  });

  final WebviewController _webviewController = WebviewController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: barColor,
      child: Column(
        children: [
          _buildHeader(data.title),
          Expanded(
            child: _buildBody(context),
          ),
          _buildFooter(),
        ],
      ),
    );
  }

  _buildHeader(String? title) {
    return Toolbar.header(
      height: headerBarHeight,
      color: barColor,
      title: Center(
        child: Text(title ?? ''),
      ),
      leadingActions: [
        ImageButton.fromIcon(
          icon: Icons.arrow_forward_ios,
          onPressed: () {
            DestinyChildService.openItemsWindow();
          },
        ),
      ],
    );
  }

  _buildFooter() {
    return Container(
      height: footerBarHeight,
      decoration: const BoxDecoration(
        color: barColor,
        border: Border(top: BorderSide(color: Colors.white70)),
      ),
      child: Row(
        children: [
          const ButtonBar(),
          Expanded(child: Container()),
          ButtonBar(
            children: [
              IconButton(
                onPressed: () {
                  _webviewController.reload();
                },
                icon: const Icon(Icons.replay),
              ),
              IconButton(
                onPressed: () async {
                  await _webviewController.openDevTools();
                },
                icon: const Icon(Icons.developer_board),
              )
            ],
          ),
        ],
      ),
    );
  }

  _buildBody(BuildContext context) {
    var settings = watchProvider<SettingsProvider>(context).settings!;
    var webviewSettings = settings.webviewSettings!;
    return FutureBuilder(
      future: render(
        data.live2dVersion == '2' ? live2dVersion2Html : live2dVersion3Html,
        data: {
          'backgroundImage': data.backgroundImage ?? '',
          'webviewHost': webviewSettings.virtualHost!,
          'live2dVersion': data.live2dVersion,
          'live2d': data.live2dSrc,
          'live2dHost': '${data.virtualHost!}/live2d',
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var html = snapshot.data!;
          return WebView(
            htmlStr: html,
            controller: _webviewController,
            virtualHosts: [
              VirtualHost(
                  virtualHost: webviewSettings.virtualHost!,
                  folderPath: webviewSettings.path!),
              VirtualHost(
                  virtualHost: data.virtualHost!, folderPath: data.folderPath!)
            ],
          );
        } else if (snapshot.hasError) {
          return ErrorDialog(message: snapshot.error.toString());
        } else {
          return Container();
        }
      },
    );
  }
}
