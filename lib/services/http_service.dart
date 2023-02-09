import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/services/cache_service.dart';
import 'package:live2d_viewer/utils/path_util.dart';
import 'package:retry/retry.dart';

class HTTPService {
  final CacheService cache = CacheService();

  final Dio http = Dio(BaseOptions(receiveTimeout: 0));

  String getSavePath(String url) {
    return PathUtil().join([
      ApplicationConstants.rootPath,
      ...Uri.parse(url).pathSegments,
    ]);
  }

  Future<File> download(String urlPath,
      {String? savePath, bool reload = false}) async {
    final localFile = File(savePath ?? getSavePath(urlPath));
    if (!localFile.existsSync() || reload) {
      try {
        await retry(
          () async {
            await http.download(urlPath, localFile.path);
          },
          retryIf: (e) => e is Error,
          maxAttempts: 3,
          maxDelay: const Duration(seconds: 3),
        );
      } on DioError {
        debugPrint(urlPath);
        rethrow;
      }
    }
    return localFile;
  }

  Future<File> get(String path,
      {Duration? duration, bool forceRefresh = false}) async {
    final response = cache.getCachedHttpResponse(path: path);
    if (cache.isUsable(response, duration: duration) && !forceRefresh) {
      return response;
    }
    try {
      final resp = await http.get<List<int>>(path,
          options: Options(responseType: ResponseType.bytes));
      cache.cacheHttpResponse(
          bytes: Int32List.fromList(resp.data!), path: path);
      return response;
    } catch (error) {
      if (response.existsSync()) {
        response.deleteSync();
      }
      rethrow;
    }
  }
}
