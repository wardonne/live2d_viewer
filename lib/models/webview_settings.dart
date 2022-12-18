import 'package:live2d_viewer/constant/webview.dart';

class WebviewSettings extends Object {
  String? virtualHost;
  String? path;

  WebviewSettings({this.virtualHost, this.path});

  WebviewSettings.init()
      : virtualHost = WebviewConstant.defaultVirtualHost,
        path = WebviewConstant.defaultPath;

  WebviewSettings.fromJson(Map<String, dynamic>? json)
      : virtualHost =
            json?['virtual_host'] ?? WebviewConstant.defaultVirtualHost,
        path = json?['path'] ?? WebviewConstant.defaultPath;

  Map<String, String?> toJson() => {
        'virtual_host': virtualHost,
        'path': path,
      };

  @override
  String toString() => toJson().toString();
}
