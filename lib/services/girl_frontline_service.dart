import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/errors/texture_download_error.dart';
import 'package:live2d_viewer/models/girl_frontline/models.dart';
import 'package:live2d_viewer/models/live2d_html_data.dart';
import 'package:live2d_viewer/models/spine_html_data.dart';
import 'package:live2d_viewer/services/base_service.dart';
import 'package:live2d_viewer/services/services.dart';
import 'package:live2d_viewer/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GirlFrontlineService extends BaseService {
  Future<List<CharacterModel>> characters({bool reload = false}) async {
    const url = GirlFrontlineConstants.characterDataURL;
    final localFile = await http.download(url, reload: reload);
    final list = jsonDecode(localFile.readAsStringSync()) as List<dynamic>;
    return list
        .map((item) => CharacterModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<String> loadSpineHtml(SpineModel spine) async {
    final resource = await SpineUtil().downloadResource(
      baseURL: GirlFrontlineConstants.characterSpineURL,
      imageBaseURL: spine.resourceURL,
      skeletonURL: spine.skelURL,
      atlasURL: spine.atlasURL,
    );

    if (resource['texture'] as String == '') {
      throw TextureDownloadError();
    }

    final skelUri = PathUtil().localAssetsUrl(resource['skel'] as String);
    final atlasUri = PathUtil().localAssetsUrl(resource['atlas'] as String);
    final textureUri = PathUtil().localAssetsUrl(resource['texture'] as String);

    final data = SpineHtmlData(
      atlasUrl: atlasUri.toString(),
      skelUrl: skelUri.toString(),
      textureUrl: textureUri.toString(),
    );

    final html =
        await rootBundle.loadString(ResourceConstants.spineVersion2127Html);
    return WebviewService.renderHtml(html, data);
  }

  Future<String> loadLive2DHtml(Live2DModel live2d,
      {bool isDestory = false}) async {
    final modelURL = isDestory ? live2d.destroyLive2D : live2d.normalLive2D;
    final baseURL = PathUtil().parent(modelURL);
    final localModelJSON = await Live2DUtil().downloadResourceV3(
      baseURL: baseURL,
      modelURL: modelURL,
    );

    final modelContent = jsonDecode(localModelJSON.readAsStringSync())
            as Map<String, dynamic>? ??
        {};
    final motions = (modelContent['FileReferences']
            as Map<String, dynamic>)['Motions'] as Map<String, dynamic>? ??
        {};
    live2d.skin.motions = motions.keys
        .map((name) => MotionModel(name, skin: live2d.skin))
        .toList();

    final live2dUri = PathUtil().localAssetsUrl(localModelJSON.path);
    final data = Live2DHtmlData(
      live2d: live2dUri.toString(),
    );
    final html = await rootBundle.loadString(ResourceConstants.live2dHtml);
    return WebviewService.renderHtml(html, data);
  }

  saveScreenshot(String data) {
    final path = PathUtil().join([
      GirlFrontlineConstants.screenshotPath,
      'images',
      '${DateTime.now().millisecondsSinceEpoch}.jpeg',
    ]);
    FileUtil().write(path, base64Decode(data));
    launchUrlString(path);
  }

  saveVideo(String data) {
    final path = PathUtil().join([
      GirlFrontlineConstants.screenshotPath,
      'videos',
      '${DateTime.now().millisecondsSinceEpoch}.webm',
    ]);
    FileUtil().write(path, base64Decode(data));
    launchUrlString(path);
  }
}
