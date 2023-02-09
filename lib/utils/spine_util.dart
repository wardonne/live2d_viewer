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
    final images = <String>[];
    final stream = await atlasFile
        .openRead()
        .map(utf8.decode)
        .transform(const LineSplitter())
        .toList();
    for (final line in stream) {
      if (line.trim().isEmpty) continue;
      if (line.split(':').length > 1) continue;
      if (images.isNotEmpty) break;
      images.add(line.trim());
    }
    return images;
  }

  Future<Map<String, String>> downloadResource({
    required String baseURL,
    required String imageBaseURL,
    required String skeletonURL,
    required String atlasURL,
  }) async {
    final localSkel = await http.download(skeletonURL);
    final localAtlas = await http.download(atlasURL);
    final images = await listTexture2DFromAltas(localAtlas);
    File? localTexture;
    for (final image in images) {
      String imageURL = '$imageBaseURL/$image';
      localTexture = await http.download(imageURL);
    }
    return <String, String>{
      'atlas': localAtlas.path,
      'skel': localSkel.path,
      'texture': localTexture?.path ?? '',
    };
  }
}
