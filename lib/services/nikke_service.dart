import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/spine_html_data.dart';
import 'package:live2d_viewer/services/cache_service.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:live2d_viewer/services/webview_service.dart';
import 'package:live2d_viewer/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NikkeService {
  final http = HTTPService();
  final cache = CacheService();

  NikkeService();

  Future<List<Character>> characters() async {
    final File response = await http.get(NikkeConstants.characterDataURL,
        duration: const Duration(days: 1));
    final List<dynamic> list = jsonDecode(response.readAsStringSync()) as List;
    return list
        .map((item) => Character.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<String> loadHtml(Skin skin, Action action) async {
    final skinURL = '${NikkeConstants.characterSpineURL}/${skin.code}';
    final cachePath = PathUtil()
        .join([ApplicationConstants.rootPath, Uri.parse(skinURL).path]);
    final resource = await SpineUtil().downloadResource(
      cacheDirectory: Directory(cachePath),
      baseURL: skinURL,
      imageBaseURL:
          action.name == 'default' ? skinURL : '$skinURL/${action.name}',
      skeletonURL: '$skinURL/${action.skel}',
      atlasURL: '$skinURL/${action.atlas}',
    );

    final skelUri = Uri(
      scheme: ApplicationConstants.localAssetsURL.scheme,
      host: ApplicationConstants.localAssetsURL.host,
      path: Uri.parse(PathUtil().relative(
        resource['skel'] as String,
        ApplicationConstants.rootPath,
      )).path,
    );

    final atlasUri = Uri(
      scheme: ApplicationConstants.localAssetsURL.scheme,
      host: ApplicationConstants.localAssetsURL.host,
      path: Uri.parse(PathUtil().relative(
        resource['atlas'] as String,
        ApplicationConstants.rootPath,
      )).path,
    );

    final data = SpineHtmlData(
      skelUrl: skelUri.toString(),
      atlasUrl: atlasUri.toString(),
      animation: action.animation,
    );
    final html =
        await rootBundle.loadString(ResourceConstants.spineVersion40Html);
    return WebviewService.renderHtml(html, data);
  }

  saveScreenshot(String data) {
    final path = PathUtil().join([
      NikkeConstants.screenshotPath,
      'images',
      '${DateTime.now().millisecondsSinceEpoch}.jpeg',
    ]);
    FileUtil().write(path, base64Decode(data));
    launchUrlString(path);
  }

  saveVideo(String data) {
    final path = PathUtil().join([
      NikkeConstants.screenshotPath,
      'videos',
      '${DateTime.now().millisecondsSinceEpoch}.webm',
    ]);
    FileUtil().write(path, base64Decode(data));
    launchUrlString(path);
  }
}
