import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/queue/queue.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// ignore: depend_on_referenced_packages

class CachedNetworkImage extends StatefulWidget {
  final String path;
  final double? width;
  final double? height;
  final String? placeholder;
  final String? queueKey;
  final BoxFit? fit;

  const CachedNetworkImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.placeholder,
    this.queueKey,
    this.fit,
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

  reload() {
    setState(() {
      _forceRefresh = true;
    });
  }

  Future<File> _download() async {
    final file = await http.download(widget.path, reload: _forceRefresh);
    if (_forceRefresh) {
      final imageProvider = FileImage(file);
      await imageProvider.evict();
    }
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: () async {
        final queue = initQueue(widget.queueKey ?? 'cachedImage');
        return queue.add(_download);
      }(),
      builder: (BuildContext context, snapshot) {
        final loading = SizedBox(
          width: widget.width,
          height: widget.height,
          child: LoadingAnimationWidget.threeArchedCircle(
            color: Styles.iconColor,
            size: Styles.iconSize,
          ),
        );
        if (snapshot.connectionState != ConnectionState.done) {
          return loading;
        }
        if (snapshot.hasData) {
          final imageKey = UniqueKey();
          final file = snapshot.data!;
          return Image.file(
            file,
            key: imageKey,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
          );
        } else if (snapshot.hasError) {
          debugPrint('${snapshot.error}');
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: widget.placeholder == null
                ? const Icon(Icons.broken_image)
                : Image.asset(widget.placeholder!),
          );
        } else {
          return loading;
        }
      },
    );
  }
}
