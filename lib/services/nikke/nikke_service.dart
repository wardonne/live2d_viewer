import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/constants/nikke.dart';
import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/spine_html_data.dart';
import 'package:live2d_viewer/services/cache_service.dart';
import 'package:live2d_viewer/services/webview_service.dart';
import 'package:live2d_viewer/utils/hash.dart';
import 'package:live2d_viewer/utils/spine_util.dart';

class NikkeService {
  NikkeService();

  Future<List<Character>> characters() async {
    final cachedHttpResponse = CacheService()
        .getCachedHttpResponse(path: NikkeConstants.characterDataURL);
    List<dynamic> list = [];
    if (CacheService()
        .isUsable(cachedHttpResponse, duration: const Duration(days: 1))) {
      list = jsonDecode(cachedHttpResponse.readAsStringSync());
    } else {
      final response = await Dio().get<List>(NikkeConstants.characterDataURL);
      if ((response.statusCode ?? 0) != 200) {
        throw ErrorDescription(response.statusMessage ?? '');
      }
      list = response.data ?? [];
      final bytes = Int32List.fromList(utf8.encode(jsonEncode(list)));
      CacheService().cacheHttpResponse(
          path: NikkeConstants.characterDataURL, bytes: bytes);
    }
    return list.map((item) => Character.fromJson(item)).toList();
  }

  String getCachePath(String skinCode, String actionName) {
    final skinMd5 = HashUtil().hashMd5(skinCode);
    final actionMd5 = HashUtil().hashMd5(actionName);
    return '${NikkeConstants.resourceCachePath}/$skinMd5/$actionMd5';
  }

  Future<String> loadHtml(Skin skin, Action action) async {
    final skinCode = skin.code;
    final skinURL = '${NikkeConstants.assetsURL}/character/spine/${skin.code}';
    debugPrint('skin url: $skinURL');
    final cachePath = getCachePath(skinCode, action.name);
    debugPrint('cache path: $cachePath');
    // download skeletion
    final skeletonURL = '$skinURL/${action.skel}';
    final skeletonMd5 = HashUtil().hashMd5(skeletonURL);
    final localSkeleton = '$cachePath/$skeletonMd5';
    debugPrint('skeleton url: $skeletonURL');
    if (!File(localSkeleton).existsSync()) {
      await Dio().download(skeletonURL, localSkeleton);
    }
    // download atlas
    final atlasURL = '$skinURL/${action.atlas}';
    final atlasMd5 = HashUtil().hashMd5(atlasURL);
    final localAtlas = '$cachePath/$atlasMd5';
    debugPrint('atlas url: $atlasURL');
    if (!File(localAtlas).existsSync()) {
      await Dio().download(atlasURL, localAtlas);
    }
    // parse image from atlas
    final images = await SpineUtil().listTexture2DFromAltas(localAtlas);
    debugPrint(images.toString());
    // download images
    for (final image in images) {
      String imageURL = '$skinURL/$image';
      if (action.name != 'default') {
        imageURL = '$skinURL/${action.name}/$image';
      }
      final localImage = '$cachePath/$image';
      debugPrint('image url: $imageURL');
      if (!File(localImage).existsSync()) {
        await Dio().download(imageURL, localImage);
      }
    }
    // load html template
    final htmlTemplate =
        await rootBundle.loadString(ResourceConstants.spineVersion40Html);
    // render html
    final html = WebviewService.renderHtml(
      htmlTemplate,
      SpineHtmlData(
        atlasUrl: 'http://${ApplicationConstants.localAssetsURL}/$atlasMd5',
        skelUrl: 'http://${ApplicationConstants.localAssetsURL}/$skeletonMd5',
        animation: action.animation,
      ),
    );
    return html;
  }
}
