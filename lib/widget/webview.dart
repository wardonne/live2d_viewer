import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/constant/keys.dart';
import 'package:webview_windows/webview_windows.dart' as webview;
import 'package:webview_windows/webview_windows.dart';

class WebView extends StatefulWidget {
  String htmlStr = '';
  String? virtualHost;
  String? folderPath;
  final WebviewController controller;

  WebView({
    super.key,
    this.htmlStr = '',
    required this.controller,
    this.virtualHost,
    this.folderPath,
  });

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
      debugPrint('init platform state');
      await _controller.initialize();
      await _controller
          .setPopupWindowPolicy(webview.WebviewPopupWindowPolicy.deny);
      await _controller.loadStringContent(widget.htmlStr);

      if (widget.virtualHost != null && widget.folderPath != null) {
        debugPrint(widget.virtualHost);
        debugPrint(widget.folderPath);
        await _controller.addVirtualHostNameMapping(
          widget.virtualHost!,
          widget.folderPath!,
          WebviewHostResourceAccessKind.denyCors,
        );
      }

      if (!mounted) {
        return;
      }
      setState(() {});
    } on PlatformException catch (e) {
      debugPrint(e.toString());
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
