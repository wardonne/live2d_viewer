import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/constant/keys.dart';
import 'package:webview_windows/webview_windows.dart' as webview;
import 'package:webview_windows/webview_windows.dart';

class WebView extends StatefulWidget {
  String htmlStr = '';

  final WebviewController controller;

  WebView({super.key, this.htmlStr = '', required this.controller});

  @override
  State<StatefulWidget> createState() {
    return WebViewState();
  }
}

class WebViewState extends State<WebView> {
  late WebviewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    initPlatformState();
  }

  void setUrl(String targetUrl) {
    _controller.loadStringContent(widget.htmlStr);
  }

  Future<void> initPlatformState() async {
    try {
      await _controller.initialize();
      await _controller
          .setPopupWindowPolicy(webview.WebviewPopupWindowPolicy.deny);
      await _controller.loadStringContent(widget.htmlStr);
      // await _controller.loadUrl('https://flutter.dev');
      if (!mounted) {
        return;
      }
      _controller.addVirtualHostNameMapping(
        'local.assets',
        'assets',
        WebviewHostResourceAccessKind.deny,
      );
      _controller.executeScript('''
      let container = window.document.getElementsByClassName('canvas-container')[0];
      console.log(container);
      container.width = window.innerWidth;
      container.height = window.innerHeight;
      ''');
      setState(() {});
    } on PlatformException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: const Text('Error'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Code: ${e.code}'),
                      Text('Message: ${e.message}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: const Text('Continue'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      });
    }
  }

  Future<webview.WebviewPermissionDecision> _onPermissionRequested(String url,
      webview.WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<webview.WebviewPermissionDecision>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, webview.WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, webview.WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? webview.WebviewPermissionDecision.none;
  }

  @override
  Widget build(BuildContext context) {
    return webview.Webview(
      _controller,
      permissionRequested: _onPermissionRequested,
    );
  }
}
