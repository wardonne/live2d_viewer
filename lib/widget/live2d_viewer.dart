import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:webview_windows/webview_windows.dart';

class Live2DViewer extends StatefulWidget {
  final WebviewController controller;
  final String html;
  final List<VirtualHost>? virtualHosts;

  const Live2DViewer({
    super.key,
    required this.controller,
    required this.html,
    this.virtualHosts,
  });

  @override
  State<StatefulWidget> createState() {
    return Live2DViewerState();
  }
}

class Live2DViewerState extends State<Live2DViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.backgroundColor,
      child: WebView(
        controller: widget.controller,
        htmlStr: widget.html,
        virtualHosts: widget.virtualHosts,
      ),
    );
  }
}
