class ImagePreviewData extends Object {
  String imageSrc;
  String? title;
  String? folder;
  ImagePreviewData({required this.imageSrc, this.title});
  @override
  String toString() {
    return '{"image_src": $imageSrc, "title": $title}';
  }
}
