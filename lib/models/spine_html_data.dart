import 'dart:convert';

class SpineHtmlData extends Object {
  final String atlasUrl;
  final String skelUrl;
  final String? textureUrl;
  final String? animation;
  final String? skin;

  SpineHtmlData({
    required this.atlasUrl,
    required this.skelUrl,
    this.textureUrl,
    this.animation,
    this.skin,
  });

  Map<String, dynamic> toJson() => {
        'atlas_url': atlasUrl,
        'skel_url': skelUrl,
        'texture_url': textureUrl,
        'animation': animation,
        'skin': skin,
      };

  @override
  String toString() => jsonEncode(toJson());
}
