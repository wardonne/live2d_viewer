import 'dart:convert';
import 'dart:io';

import 'package:live2d_viewer/services/cache_service.dart';
import 'package:live2d_viewer/services/http_service.dart';

class SpineUtil {
  final CacheService cache = CacheService();
  final HTTPService http = HTTPService();

  Future<List<String>> listTexture2DFromAltas(File atlasFile) async {
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
    final localSkel = await http.download(skeletonURL);
    final localAtlas = await http.download(atlasURL);
    final images = await listTexture2DFromAltas(localAtlas);
    for (final image in images) {
      String imageURL = '$imageBaseURL/$image';
      await http.download(imageURL);
    }
    return <String, String>{
      'atlas': localAtlas.path,
      'skel': localSkel.path,
    };
  }
}
