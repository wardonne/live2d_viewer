import 'dart:convert';
import 'dart:io';

import 'package:live2d_viewer/services/cache_service.dart';
import 'package:live2d_viewer/services/http_service.dart';

class Live2DUtil {
  final CacheService cache = CacheService();
  final HTTPService http = HTTPService();

  Future<File> downloadResource({
    required Directory cacheDirectory,
    required String baseURL,
    required String modelJSON,
    Duration? duration,
  }) async {
    final modelURL = '$baseURL/$modelJSON';
    final localModelJSON = await http.download(modelURL);
    final Map<String, dynamic> model =
        jsonDecode(localModelJSON.readAsStringSync()) as Map<String, dynamic>;
    final modelDat = model['model'] as String;
    await http.download('$baseURL/$modelDat');

    final textures = model['textures'] as List<dynamic>;
    for (final texture in textures) {
      await http.download('$baseURL/$texture');
    }

    final expressions = model['expressions'] as List<dynamic>? ?? [];
    for (var expression in expressions) {
      expression = expression as Map<String, dynamic>;
      await http.download('$baseURL/${expression["file"]}');
    }

    final motionGroups = model['motions'] as Map<String, dynamic>? ?? {};
    for (var key in motionGroups.keys) {
      for (var motion in motionGroups[key] as List<dynamic>) {
        await http.download('$baseURL/${motion["file"]}');
      }
    }
    return localModelJSON;
  }
}
