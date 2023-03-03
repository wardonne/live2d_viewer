import 'dart:convert';
import 'dart:io';

import 'package:live2d_viewer/services/http_service.dart';

class Live2DUtil {
  final HTTPService http = HTTPService();

  Future<File> downloadResourceV2({
    required String baseURL,
    required String modelURL,
    bool reload = false,
  }) async {
    final localModelJSON = await http.download(modelURL, reload: reload);
    final Map<String, dynamic> model =
        jsonDecode(localModelJSON.readAsStringSync()) as Map<String, dynamic>;
    final modelDat = model['model'] as String;
    await http.download('$baseURL/$modelDat', reload: reload);

    final futures = <Future<File>>[];

    final textures = model['textures'] as List<dynamic>;
    for (final texture in textures) {
      futures.add(http.download('$baseURL/$texture', reload: reload));
    }

    final expressions = model['expressions'] as List<dynamic>? ?? [];
    for (var expression in expressions) {
      expression = expression as Map<String, dynamic>;
      futures.add(http.download(
        '$baseURL/${expression["file"]}',
        reload: reload,
      ));
    }

    final motionGroups = model['motions'] as Map<String, dynamic>? ?? {};
    for (var key in motionGroups.keys) {
      for (var motion in motionGroups[key] as List<dynamic>) {
        futures.add(http.download(
          '$baseURL/${motion["file"]}',
          reload: reload,
        ));
      }
    }
    await Future.wait(futures);
    return localModelJSON;
  }

  Future<File> downloadResourceV3({
    required String baseURL,
    required String modelURL,
    bool reload = false,
  }) async {
    final localModelJSON = await http.download(modelURL, reload: reload);
    final model =
        jsonDecode(localModelJSON.readAsStringSync()) as Map<String, dynamic>;

    final references = model['FileReferences'] as Map<String, dynamic>;

    final futures = <Future<File>>[];

    final modelMoc3 = references['Moc'] as String;
    futures.add(http.download('$baseURL/$modelMoc3', reload: reload));

    final textures = references['Textures'] as List<dynamic>;
    for (final texture in textures) {
      futures.add(http.download('$baseURL/$texture', reload: reload));
    }

    final physics = references['Physics'] as String?;
    if (physics != null) {
      futures.add(http.download('$baseURL/$physics', reload: reload));
    }

    final motions = references['Motions'] as Map<String, dynamic>?;
    if (motions != null) {
      motions.forEach((motion, items) {
        for (final item in (items as List<dynamic>)) {
          futures.add(http.download(
            '$baseURL/${(item as Map<String, dynamic>)["File"] as String}',
            reload: reload,
          ));
        }
      });
    }
    await Future.wait(futures);
    return localModelJSON;
  }
}
