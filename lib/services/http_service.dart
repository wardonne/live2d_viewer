import 'dart:async';
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

  final CancelToken cancelToken = CancelToken();

  String getSavePath(String url) {
    return PathUtil().join([
      ApplicationConstants.rootPath,
      ...Uri.parse(url).pathSegments,
    ]);
  }

  Future<File> download(String urlPath,
      {String? savePath, bool reload = false}) async {
    final localFile = File(savePath ?? getSavePath(urlPath));
    final tmpFile = File('${localFile.path}.tmp');
    if (!localFile.existsSync() || reload) {
      final completer = Completer();
      try {
        await retry(
          () async {
            if (!tmpFile.existsSync()) {
              tmpFile.createSync(recursive: true);
            }
            final startBytes = tmpFile.lengthSync();
            final response = await http.get<ResponseBody>(urlPath,
                options: Options(
                  responseType: ResponseType.stream,
                  followRedirects: false,
                  headers: {
                    'Range': 'bytes=$startBytes-',
                  },
                ));
            final raf = tmpFile.openSync(mode: FileMode.append);
            final stream = response.data!.stream;
            final StreamSubscription<Uint8List>? subscription;
            subscription = stream.listen(
              (data) {
                raf.writeFromSync(data);
              },
              onDone: () {
                raf.closeSync();
                completer.complete();
              },
              onError: (e) {
                raf.closeSync();
              },
              cancelOnError: true,
            );
            cancelToken.whenCancel.then((_) async {
              await subscription?.cancel();
              await raf.close();
            });
          },
          retryIf: (e) {
            if (e is DioError && e.response!.statusCode == 416) {
              tmpFile.deleteSync();
            }
            return e is! DioError || !CancelToken.isCancel(e);
          },
          maxAttempts: 3,
          maxDelay: const Duration(seconds: 3),
        );
        await completer.future;
        tmpFile.renameSync(localFile.path);
      } on DioError catch (e) {
        debugPrint('error with $urlPath');
        debugPrint(e.toString());
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
