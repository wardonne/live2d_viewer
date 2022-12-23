import 'dart:convert';

class Live2DHtmlData extends Object {
  final String? live2d;
  final String? backgroundImage;
  final bool hasBackgroundImage;
  final String? webviewHost;
  final bool canSetMotion;
  final bool canSetExpression;

  Live2DHtmlData({
    this.live2d,
    this.backgroundImage,
    this.webviewHost,
    this.canSetExpression = true,
    this.canSetMotion = true,
  }) : hasBackgroundImage = backgroundImage != null;

  Map<String, dynamic> toJson() => {
        'live2d': live2d,
        'background_image': backgroundImage,
        'has_background_image': hasBackgroundImage,
        'webview_host': webviewHost,
        'can_set_expression': canSetExpression,
        'can_set_motion': canSetMotion,
      };

  @override
  String toString() => jsonEncode(toJson());
}
