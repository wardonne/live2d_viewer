class ImagePreviewData extends Object {
  String imageSrc;
  String? title;
  ImagePreviewData({required this.imageSrc, this.title});
  @override
  String toString() {
    return '{"image_src": $imageSrc, "title": $title}';
  }
}
