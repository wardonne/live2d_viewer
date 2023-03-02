import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/enum/spine_painting_layer_type.dart';
import 'package:live2d_viewer/errors/texture_download_error.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/models/azurlane/spine_painting_model.dart';
import 'package:live2d_viewer/models/live2d_html_data.dart';
import 'package:live2d_viewer/models/spine_html_data.dart';
import 'package:live2d_viewer/models/spine_layer_html_data.dart';
import 'package:live2d_viewer/services/base_service.dart';
import 'package:live2d_viewer/services/webview_service.dart';
import 'package:live2d_viewer/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AzurlaneService extends BaseService {
  Future<List<CharacterModel>> characters(
      {FilterFormModel? filter, bool reload = false}) async {
    const url = AzurlaneConstants.characterDataURL;
    final localFile = await http.download(url, reload: reload);
    final list = jsonDecode(localFile.readAsStringSync()) as List<dynamic>;
    final filteredList = list
        .where((item) {
          item = item as Map<String, dynamic>;
          if (filter == null) return true;
          if (filter.name.isNotEmpty && item['name'] as String != filter.name) {
            return false;
          }
          if (filter.rarity.isNotEmpty &&
              !filter.rarity.contains(item['rarity'] as int)) {
            return false;
          }
          if (filter.type.isNotEmpty &&
              !filter.type.contains(item['type'] as int)) {
            return false;
          }
          if (filter.nationality.isNotEmpty &&
              !filter.nationality.contains(item['nationality'] as int)) {
            return false;
          }
          return true;
        })
        .map((item) => CharacterModel.fromJson(item as Map<String, dynamic>))
        .toList();
    return filteredList..sort((a, b) => a.compareTo(b));
  }

  Future<String> loadSpineHtml(SpineModel spine) async {
    final resource = await SpineUtil().downloadResource(
      baseURL: AzurlaneConstants.characterSpineURL,
      skeletonURL: spine.skelURL,
      atlasURL: spine.atlasURL,
    );

    if (resource['texture'] as String == '') {
      throw TextureDownloadError();
    }

    final skelUri = PathUtil().localAssetsUrl(resource['skel'] as String);
    final atlasUri = PathUtil().localAssetsUrl(resource['atlas'] as String);

    final data = SpineHtmlData(
      atlasUrl: atlasUri.toString(),
      skelUrl: skelUri.toString(),
      animation: AzurlaneConstants.defaultSDAnimation,
    );

    final html =
        await rootBundle.loadString(ResourceConstants.spineVersion3652Html);
    return WebviewService.renderHtml(html, data);
  }

  Future<String> loadLive2DHtml(SkinModel skin) async {
    final modelURL = skin.live2dURL;
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

    skin.motions = motions.keys.map((item) {
      return MotionModel(name: item, skin: skin);
    }).toList();

    final live2dUri = PathUtil().localAssetsUrl(localModelJSON.path);
    final data = Live2DHtmlData(
      live2d: live2dUri.toString(),
    );
    final html = await rootBundle.loadString(ResourceConstants.live2dHtml);
    return WebviewService.renderHtml(html, data);
  }

  Future<String> loadSpinePaintingHtml(SkinModel skin) async {
    final spinePaintingConfig = await http.download(skin.spinePaintingURL);
    final spinePaintingModel = SpinePaintingModel.fromJson(
        jsonDecode(spinePaintingConfig.readAsStringSync())
            as Map<String, dynamic>);
    final futures = <Future<Map<String, dynamic>>>[];
    for (final layer in spinePaintingModel.layers) {
      final baseUrl = PathUtil().parent(skin.spinePaintingURL);
      if (layer.type == SpinePaintingLayerType.spine) {
        futures.add(() async {
          final resource = await SpineUtil().downloadResource(
            baseURL: baseUrl,
            skeletonURL: '$baseUrl/${layer.skel}',
            atlasURL: '$baseUrl/${layer.atlas}',
          );
          return <String, String>{
            'type': layer.type.value,
            'skel': PathUtil()
                .localAssetsUrl(resource['skel'] as String)
                .toString(),
            'atlas': PathUtil()
                .localAssetsUrl(resource['atlas'] as String)
                .toString(),
          };
        }());
      } else if (layer.type == SpinePaintingLayerType.image) {
        futures.add(() async {
          final texture = await http.download('$baseUrl/${layer.texture}');
          return <String, dynamic>{
            'type': layer.type.value,
            'texture': PathUtil().localAssetsUrl(texture.path).toString(),
            'size': layer.size,
            'offset': layer.offset,
          };
        }());
      }
    }
    final layers = await Future.wait(futures);
    final html = await rootBundle
        .loadString(ResourceConstants.azurlaneSpintPaintingHtml);
    return WebviewService.renderHtml(html, SpineLayerHtmlData(layers: layers));
  }

  saveScreenshot(String data) {
    final path = PathUtil().join([
      AzurlaneConstants.screenshotPath,
      'images',
      '${DateTime.now().millisecondsSinceEpoch}.jpeg',
    ]);
    FileUtil().write(path, base64Decode(data));
    launchUrlString(path);
  }

  saveVideo(String data) {
    final path = PathUtil().join([
      AzurlaneConstants.screenshotPath,
      'videos',
      '${DateTime.now().millisecondsSinceEpoch}.webm',
    ]);
    FileUtil().write(path, base64Decode(data));
    FfmpegUtil()
        .convert(path, path.replaceAll(RegExp(r'.webm'), '.mp4'))
        .then((result) {
      launchUrlString(path);
    });
  }

  Future<File> setFace(SkinModel skin) async {
    final cachedImage = File(PathUtil().join([
      AzurlaneConstants.cachedFacePaintingPath,
      skin.code,
      '${skin.activeFaceIndex}.png',
    ]));
    if (cachedImage.existsSync()) {
      return cachedImage;
    }

    final painting = await http.download(skin.paintingURL);
    final face = await http.download(skin.activeFaceURL);
    final faceRect = await http.download(skin.faceRectURL);
    final faceRectModel = FaceRectModel.fromJson(
        jsonDecode(faceRect.readAsStringSync()) as Map<String, dynamic>);

    var paintingImg = decodePng(painting.readAsBytesSync());
    var faceImg = decodePng(face.readAsBytesSync());

    paintingImg = flip(paintingImg!, direction: FlipDirection.vertical);
    faceImg = flip(faceImg!, direction: FlipDirection.vertical);

    final offsetX = paintingImg.width / 2 -
        faceRectModel.pivot[0] * faceImg.width +
        faceRectModel.position[0];
    final offsetY = paintingImg.height / 2 -
        faceRectModel.pivot[1] * faceImg.height +
        faceRectModel.position[1];
    final mergedImage = flip(
      compositeImage(
        paintingImg,
        faceImg,
        dstX: offsetX.round(),
        dstY: offsetY.round(),
      ),
      direction: FlipDirection.vertical,
    );
    final data = encodePng(mergedImage);
    FileUtil().writeFile(cachedImage, data);
    return cachedImage;
  }
}
