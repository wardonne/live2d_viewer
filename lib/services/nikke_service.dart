import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/nikke/models.dart';
import 'package:live2d_viewer/models/spine_html_data.dart';
import 'package:live2d_viewer/services/base_service.dart';
import 'package:live2d_viewer/services/services.dart';
import 'package:live2d_viewer/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NikkeService extends BaseService {
  final cache = CacheService();

  NikkeService();

  Future<List<CharacterModel>> characters(
      {String name = '', bool reload = false}) async {
    const url = NikkeConstants.characterDataURL;
    final localFile = await http.download(url, reload: reload);
    final list = jsonDecode(localFile.readAsStringSync()) as List<dynamic>;
    return list.where((item) {
      if (name.isEmpty) return true;
      if (!(item['enable'] as bool)) return false;
      return item['name'] as String == name;
    }).map((item) {
      return CharacterModel.fromJson(item as Map<String, dynamic>);
    }).toList();
  }

  Future<String> loadHtml(ActionModel action) async {
    debugPrint(action.skelURL);
    final resource = await SpineUtil().downloadResource(
      baseURL: action.spineURL,
      skeletonURL: action.skelURL,
      atlasURL: action.atlasURL,
    );

    final skelUri = PathUtil().localAssetsUrl(resource['skel'] as String);
    final atlasUri = PathUtil().localAssetsUrl(resource['atlas'] as String);

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
