import 'dart:convert';
import 'dart:io';

import 'package:live2d_viewer/services/cache_service.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:live2d_viewer/utils/hash_util.dart';
import 'package:live2d_viewer/utils/path_util.dart';

class Live2DUtil {
  final CacheService cache = CacheService();
  final HTTPService http = HTTPService();

  Future<String> downloadResource({
    required Directory cacheDirectory,
    required String baseURL,
    required String modelJSON,
    Duration? duration,
  }) async {
    final modelURL = '$baseURL/$modelJSON';
    final modelMd5 = HashUtil().hashMd5(modelURL);
    final localModelJSON = PathUtil().join([cacheDirectory.path, modelMd5]);
    if (!cache.isDirectoryUsable(cacheDirectory)) {
      await http.download(modelURL, localModelJSON);

      final Map<String, dynamic> model =
          jsonDecode(File(localModelJSON).readAsStringSync())
              as Map<String, dynamic>;
      final modelDat = model['model'] as String;
      await http.download('$baseURL/$modelDat',
          PathUtil().join([cacheDirectory.path, modelDat]));

      final textures = model['textures'] as List<dynamic>;
      for (final texture in textures) {
        await http.download('$baseURL/$texture',
            PathUtil().join([cacheDirectory.path, texture as String]));
      }

      final expressions = model['expressions'] as List<dynamic>? ?? [];
      for (var expression in expressions) {
        expression = expression as Map<String, dynamic>;
        await http.download(
          '$baseURL/${expression["file"]}',
          PathUtil().join([cacheDirectory.path, expression['file'] as String]),
        );
      }

      final motionGroups = model['motions'] as Map<String, dynamic>? ?? {};
      for (var key in motionGroups.keys) {
        for (var motion in motionGroups[key] as List<dynamic>) {
          await http.download(
            '$baseURL/${motion["file"]}',
            PathUtil().join([cacheDirectory.path, motion['file'] as String]),
          );
        }
      }
    }
    return localModelJSON;
  }
}
