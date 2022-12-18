import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/constant/settings.dart';
import 'package:live2d_viewer/models/live2d_preview_data.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:window_manager/window_manager.dart';

class Live2DPreviewWindow extends StatelessWidget {
  final Live2DPreviewData data;
  Live2DPreviewWindow({super.key, required this.data});

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
                  child: _buildBody(),
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

  Future<String> _loadHtml() async {
    var content =
        await rootBundle.loadString('assets/html/destiny_child_live2d.html');
    return content;
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
                  var uri = Uri.parse('https://baidu.com');
                  var canLaunch = await canLaunchUrl(uri);
                  if (canLaunch) {
                    launchUrl(
                      Uri.parse('https://baidu.com'),
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    debugPrint('can not launch uri: $uri');
                  }
                },
                icon: const Icon(Icons.open_in_browser),
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

  _buildBody() {
    return FutureBuilder(
      future: _loadHtml(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var html = snapshot.data!;
          return WebView(
            htmlStr: html,
            controller: _webviewController,
            virtualHost: data.virtualHost,
            folderPath: data.folderPath,
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
