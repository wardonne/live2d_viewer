import 'dart:convert';

class Live2DHtmlData extends Object {
  final String? live2d;
  final String? backgroundImage;
  final bool hasBackgroundImage;
  final bool canSetMotion;
  final bool canSetExpression;
  final bool movable;

  Live2DHtmlData({
    this.live2d,
    this.backgroundImage,
    this.canSetExpression = true,
    this.canSetMotion = true,
    this.movable = true,
  }) : hasBackgroundImage = backgroundImage != null;

  Map<String, dynamic> toJson() => {
        'live2d': live2d,
        'background_image': backgroundImage,
        'has_background_image': hasBackgroundImage,
        'can_set_expression': canSetExpression,
        'can_set_motion': canSetMotion,
      };

  @override
  String toString() => jsonEncode(toJson());
}
