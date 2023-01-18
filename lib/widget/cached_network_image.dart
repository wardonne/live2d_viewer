import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// ignore: depend_on_referenced_packages

class CachedNetworkImage extends StatefulWidget {
  final String path;
  final double? width;
  final double? height;
  final String? placeholder;
  final bool? cache;
  final Duration? cacheTime;

  const CachedNetworkImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.cache = true,
    this.cacheTime,
    this.placeholder,
  });

  @override
  State<StatefulWidget> createState() {
    return CachedNetworkImageState();
  }
}

class CachedNetworkImageState extends State<CachedNetworkImage> {
  final HTTPService http = HTTPService();
  bool _forceRefresh = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> reload() async {
    setState(() {
      _forceRefresh = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.downloadImage(widget.path, forceRefresh: _forceRefresh),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Image.file(
            snapshot.data!,
            width: widget.width,
            height: widget.height,
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: widget.placeholder == null
                ? const Icon(Icons.broken_image)
                : Image.asset(widget.placeholder!),
          );
        } else {
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: LoadingAnimationWidget.threeArchedCircle(
              color: Styles.iconColor,
              size: Styles.iconSize,
            ),
          );
        }
      },
    );
  }
}
