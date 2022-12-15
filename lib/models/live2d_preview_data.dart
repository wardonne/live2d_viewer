class Live2DPreviewData extends Object {
  String? title;
  String live2dSrc;
  int live2dVersion;
  Live2DPreviewData({
    required this.live2dSrc,
    required this.live2dVersion,
    this.title,
  });
  @override
  String toString() {
    return '{"live2d_src": $live2dSrc, "live2d_version": $live2dVersion, "title": $title}';
  }
}
