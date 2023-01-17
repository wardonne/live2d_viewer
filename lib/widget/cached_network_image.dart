import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/services/cache_service.dart';
import 'package:live2d_viewer/utils/hash_util.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// ignore: depend_on_referenced_packages

class CachedNetworkImage extends StatefulWidget {
  final String path;
  final double? width;
  final double? height;
  final String? placeholder;
  final bool? cache;
  String? cacheKey;
  final Duration? cacheTime;

  CachedNetworkImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.cache = true,
    this.cacheKey,
    this.cacheTime,
    this.placeholder,
  }) {
    if (cache!) {
      cacheKey ??= HashUtil().hashMd5(path);
    }
  }

  File get _cachedImage =>
      CacheService().getCachedImage(path: path, cacheKey: cacheKey);

  @override
  State<StatefulWidget> createState() {
    return CachedNetworkImageState();
  }
}

class CachedNetworkImageState extends State<CachedNetworkImage> {
  late File _cachedImage;

  @override
  void initState() {
    super.initState();
    _cachedImage = widget._cachedImage;
  }

  Future<void> reload() async {
    await Dio().download(widget.path, widget._cachedImage.path);
    setState(() {});
  }

  Future<Image> fetchImage() async {
    debugPrint('fetch image');
    if (!CacheService()
        .isUsable(widget._cachedImage, duration: widget.cacheTime)) {
      await Dio().download(widget.path, _cachedImage.path).catchError((error) {
        if (widget._cachedImage.existsSync()) {
          widget._cachedImage.deleteSync();
        }
      });
    }
    return Image.file(
      _cachedImage,
      width: widget.width,
      height: widget.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchImage(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!;
        } else if (snapshot.hasError) {
          return widget.placeholder == null
              ? SizedBox(
                  width: widget.width,
                  height: widget.height,
                  child: const Icon(Icons.broken_image),
                )
              : Image.asset(
                  widget.placeholder!,
                  width: widget.width,
                  height: widget.height,
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
