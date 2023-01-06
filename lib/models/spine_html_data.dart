import 'dart:convert';

class SpineHtmlData extends Object {
  final String atlasUrl;
  final String skelUrl;
  final String? animation;
  final String? skin;
  final String? webviewHost;

  SpineHtmlData({
    required this.atlasUrl,
    required this.skelUrl,
    this.animation,
    this.skin,
    this.webviewHost,
  });

  Map<String, dynamic> toJson() => {
        'atlas_url': atlasUrl,
        'skel_url': skelUrl,
        'animation': animation,
        'skin': skin,
        'webview_host': webviewHost,
      };

  @override
  String toString() => jsonEncode(toJson());
}