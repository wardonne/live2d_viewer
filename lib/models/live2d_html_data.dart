import 'dart:convert';

class Live2DHtmlData extends Object {
  final String? live2d;
  final String? backgroundImage;
  final bool hasBackgroundImage;
  final String? webviewHost;

  Live2DHtmlData({
    this.live2d,
    this.backgroundImage,
    this.webviewHost,
  }) : hasBackgroundImage = backgroundImage != null;

  Map<String, dynamic> toJson() => {
        'live2d': live2d,
        'background_image': backgroundImage,
        'has_background_image': hasBackgroundImage,
        'webview_host': webviewHost,
      };

  @override
  String toString() => jsonEncode(toJson());
}
