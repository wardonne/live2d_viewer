import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/utils/hash.dart';
import 'package:path/path.dart' as p;

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

  File get _cachedImage {
    return File(p.join(ApplicationConstants.cachePath, 'images', cacheKey));
  }

  bool get _overtime {
    if (cacheTime == null) {
      return false;
    } else {
      return _cachedImage
          .lastModifiedSync()
          .add(cacheTime!)
          .isAfter(DateTime.now());
    }
  }

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
    if (!_cachedImage.existsSync() || widget._overtime) {
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
        } else {
          return widget.placeholder == null
              ? SizedBox(
                  width: widget.width,
                  height: widget.height,
                )
              : Image.asset(
                  widget.placeholder!,
                  width: widget.width,
                  height: widget.height,
                );
        }
      },
    );
  }
}
