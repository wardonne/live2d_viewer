import 'package:flutter/material.dart';
import 'package:live2d_viewer/constant/resources.dart';
import 'package:live2d_viewer/constant/settings.dart';
import 'package:live2d_viewer/models/live2d_preview_data.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/utils/render.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/preview_windows/preview_window.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:window_manager/window_manager.dart';

class Live2DPreviewWindow extends StatelessWidget {
  final Live2DPreviewData data;
  final PreviewWindowController previewWindowController;
  Live2DPreviewWindow({
    super.key,
    required this.data,
    required this.previewWindowController,
  });

  final WebviewController _webviewController = WebviewController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: windowManager.getSize(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var width = snapshot.data!.width;
          return Container(
            width: width * 0.4,
            decoration: const BoxDecoration(
              color: barColor,
              border: Border(left: BorderSide(color: Colors.white70)),
            ),
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
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return ErrorDialog(message: snapshot.error.toString());
        } else {
          debugPrint('empty data');
          return Container(
            width: 500,
            color: barColor,
            child: const Center(
              child: Text('empty data'),
            ),
          );
        }
      },
    );
  }

  _buildHeader(String? title) {
    return Container(
      height: headerBarHeight,
      decoration: const BoxDecoration(
        color: barColor,
        border: Border(
          bottom: BorderSide(color: Colors.white70),
        ),
      ),
      child: title != null ? Center(child: Text(title)) : const Center(),
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
    var soulCartaSettings = settings.destinyChildSettings!.soulCartaSettings!;
    return FutureBuilder(
      future: render(
        data.live2dVersion == '2' ? live2dVersion2Html : live2dVersion3Html,
        data: {
          'backgroundImage': data.backgroundImage != null
              ? '${soulCartaSettings.imageHost}/${data.backgroundImage}'
              : '',
          'webviewHost': webviewSettings.virtualHost!,
          'live2dVersion': data.live2dVersion,
          'live2d': data.live2dSrc,
          'live2dHost': soulCartaSettings.live2dHost,
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var html = snapshot.data!;
          return AnimatedBuilder(
            animation: previewWindowController,
            builder: (context, child) {
              return WebView(
                htmlStr: html,
                controller: _webviewController,
                virtualHosts: [
                  VirtualHost(
                      virtualHost: webviewSettings.virtualHost!,
                      folderPath: webviewSettings.path!),
                  VirtualHost(
                      virtualHost: data.virtualHost!,
                      folderPath: data.folderPath!)
                ],
              );
            },
          );
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return ErrorDialog(message: snapshot.error.toString());
        } else {
          return Container();
        }
      },
    );
  }
}
