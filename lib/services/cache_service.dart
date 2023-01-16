import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/errors/invalid_params_error.dart';
import 'package:live2d_viewer/utils/hash.dart';
import 'package:path/path.dart' as p;

class CacheService {
  String buildCachePath({String? path, String? cacheKey}) {
    if (path == null && cacheKey == null) {
      throw InvalidParamsError();
    }
    cacheKey ??= HashUtil().hashMd5(path!);
    return p.join(cacheKey.substring(0, 2),
        cacheKey.substring(cacheKey.length - 2), cacheKey);
  }

  bool isUsable(File file, {Duration? duration}) {
    if (file.existsSync()) {
      if (duration != null) {
        return file.lastModifiedSync().add(duration).isAfter(DateTime.now());
      }
      return true;
    }
    return false;
  }

  File getCachedImage({String? path, String? cacheKey}) {
    final cachePath = p.join(
      ApplicationConstants.imageCachePath,
      buildCachePath(cacheKey: cacheKey, path: path),
    );
    return File(cachePath);
  }

  File getCachedHttpResponse({String? path, String? cacheKey}) {
    final cachePath = p.join(
      ApplicationConstants.httpCachePath,
      buildCachePath(cacheKey: cacheKey, path: path),
    );
    return File(cachePath);
  }

  cacheHttpResponse({
    String? path,
    String? cacheKey,
    required Int32List bytes,
  }) {
    final cacheFile = getCachedHttpResponse(path: path, cacheKey: cacheKey);
    if (!cacheFile.existsSync()) {
      cacheFile.createSync(recursive: true);
    }
    cacheFile.writeAsBytesSync(bytes);
  }
}
