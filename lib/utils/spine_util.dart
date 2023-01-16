import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';

class SpineUtil {
  Future<List<String>> listTexture2DFromAltas(String path) async {
    debugPrint(path);
    final atlasFile = File(path);
    if (!atlasFile.existsSync()) {
      return [];
    }
    var images = <String>[];
    await atlasFile
        .openRead()
        .map(utf8.decode)
        .transform(const LineSplitter())
        .forEach((line) {
      if (line.trim().isEmpty) return;
      if (line.split(':').length > 1) return;
      if (images.isNotEmpty) return;
      images.add(line.trim());
    });
    return images;
  }
}
