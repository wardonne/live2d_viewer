import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:live2d_viewer/services/cache_service.dart';

class HTTPService {
  final CacheService cache = CacheService();

  final Dio http = Dio(BaseOptions(receiveTimeout: 0));

  Future<void> download(String urlPath, String savePath) {
    return http.download(urlPath, savePath);
  }

  Future<File> downloadImage(String path, {bool forceRefresh = false}) async {
    final image = cache.getCachedImage(path: path);
    if (cache.isUsable(image) && !forceRefresh) {
      return image;
    }
    try {
      await http.download(path, image.path);
      return image;
    } catch (error) {
      if (image.existsSync()) {
        image.deleteSync();
      }
      debugPrint(error.toString());
      rethrow;
    }
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
      debugPrint(error.toString());
      rethrow;
    }
  }
}
