import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:webview_windows/webview_windows.dart';

class SpineViewer extends StatefulWidget {
  final WebviewController controller;
  final String html;
  final List<VirtualHost>? virtualHosts;

  const SpineViewer({
    super.key,
    required this.controller,
    required this.html,
    this.virtualHosts,
  });

  @override
  State<StatefulWidget> createState() {
    return SpineViewerState();
  }
}

class SpineViewerState extends State<SpineViewer> {
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
