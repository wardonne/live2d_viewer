import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/services/cache_service.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:live2d_viewer/utils/hash_util.dart';
import 'package:live2d_viewer/utils/path_util.dart';

class SpineUtil {
  final CacheService cache = CacheService();
  final HTTPService http = HTTPService();

  Future<List<String>> listTexture2DFromAltas(String path) async {
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

  Future<Map<String, String>> downloadResource({
    required Directory cacheDirectory,
    required String baseURL,
    required String imageBaseURL,
    required String skeletonURL,
    required String atlasURL,
    Duration? duration,
  }) async {
    final String atlasMd5 = HashUtil().hashMd5(atlasURL);
    final String skeletonMd5 = HashUtil().hashMd5(skeletonURL);
    if (!cache.isDirectoryUsable(cacheDirectory)) {
      try {
        final localSkel = PathUtil().join([cacheDirectory.path, skeletonMd5]);
        await http.download(skeletonURL, localSkel);

        final localAtlas = PathUtil().join([cacheDirectory.path, atlasMd5]);
        await http.download(atlasURL, localAtlas);

        final images = await listTexture2DFromAltas(localAtlas);
        for (final image in images) {
          String imageURL = '$imageBaseURL/$image';
          String localImage = PathUtil().join([cacheDirectory.path, image]);
          await http.download(imageURL, localImage);
        }
      } catch (error) {
        debugPrint('error with url: ${error.toString()}');
        rethrow;
      }
    }
    return <String, String>{
      'atlas': atlasMd5,
      'skel': skeletonMd5,
    };
  }
}
