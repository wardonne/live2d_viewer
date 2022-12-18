class Live2DPreviewData extends Object {
  String? title;
  String live2dSrc;
  int live2dVersion;
  String? virtualHost;
  String? folderPath;
  Live2DPreviewData({
    required this.live2dSrc,
    required this.live2dVersion,
    this.title,
    this.virtualHost,
    this.folderPath,
  });

  _toJson() {
    return <String, dynamic>{
      'title': title,
      'live2d_src': live2dSrc,
      'live2d_version': live2dVersion,
      'virtual_host': virtualHost,
      'folderPath': folderPath,
    };
  }

  @override
  String toString() => _toJson().toString();
}
