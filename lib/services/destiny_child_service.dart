import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/destiny_child/models.dart';
import 'package:live2d_viewer/models/live2d_html_data.dart';
import 'package:live2d_viewer/services/services.dart';
import 'package:live2d_viewer/utils/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DestinyChildService {
  final HTTPService http = HTTPService();

  String getModelJSON(String code) {
    return DestinyChildConstants.modelJSONFormat.replaceAll('%s', code);
  }

  Future<List<CharacterModel>> characters({bool reload = false}) async {
    const url = DestinyChildConstants.characterDataURL;
    final localFile = await http.download(url, reload: reload);
    final list = jsonDecode(localFile.readAsStringSync()) as List<dynamic>;
    return list
        .map((item) => CharacterModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<SoulCartaModel>> soulCartas({bool reload = false}) async {
    const url = DestinyChildConstants.soulCartaDataURL;
    final localFile = await http.download(url, reload: reload);
    final list = jsonDecode(localFile.readAsStringSync()) as List<dynamic>;
    return list
        .map((item) => SoulCartaModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<String> loadCharacterHTML(SkinModel skin) async {
    final modelJSONFile = await Live2DUtil().downloadResourceV2(
      baseURL: skin.live2dURL,
      modelURL: skin.modelURL,
    );
    final modelContent =
        jsonDecode(modelJSONFile.readAsStringSync()) as Map<String, dynamic>? ??
            {};
    final expressions = modelContent['expressions'] as List<dynamic>? ?? [];
    skin.expressions = expressions
        .map((expression) => ExpressionModel(
              name: expression['name'] as String? ?? '',
              file: expression['file'] as String? ?? '',
            )..skin = skin)
        .toList();
    final motionGroups = modelContent['motions'] as Map<String, dynamic>? ?? {};
    skin.motions = motionGroups.keys
        .map(
          (name) => MotionModel.fromJson({
            'name': name,
            'configs': motionGroups[name],
          })
            ..skin = skin,
        )
        .toList();

    final live2dUri = PathUtil().localAssetsUrl(modelJSONFile.path);

    final data = Live2DHtmlData(
      live2d: live2dUri.toString(),
    );
    final html = await rootBundle.loadString(ResourceConstants.live2dHtml);
    return WebviewService.renderHtml(html, data);
  }

  Future<String> loadSoulCartaHTML(SoulCartaModel soulCarta) async {
    final modelJSON = await Live2DUtil().downloadResourceV2(
      baseURL: soulCarta.live2dURL!,
      modelURL: soulCarta.modelURL!,
    );
    final backgroundImage = await http.download(soulCarta.imageURL);
    final live2dUri = Uri(
      scheme: ApplicationConstants.localAssetsURL.scheme,
      host: ApplicationConstants.localAssetsURL.host,
      path: Uri.parse(PathUtil()
              .relative(modelJSON.path, ApplicationConstants.rootPath))
          .path,
    );
    final data = Live2DHtmlData(
      live2d: live2dUri.toString(),
      backgroundImage:
          'data:image/png;base64,${base64Encode(backgroundImage.readAsBytesSync())}',
      canSetExpression: false,
      canSetMotion: false,
      movable: false,
    );
    final html =
        await rootBundle.loadString(ResourceConstants.live2dVersion2Html);
    return WebviewService.renderHtml(html, data);
  }

  saveSreenshot(String data) {
    final path = PathUtil().join([
      DestinyChildConstants.screenshotPath,
      'images',
      '${DateTime.now().millisecondsSinceEpoch}.jpeg',
    ]);
    FileUtil().write(path, base64Decode(data));
    launchUrlString(path);
  }

  saveVideo(String data) {
    final path = PathUtil().join([
      DestinyChildConstants.screenshotPath,
      'videos',
      '${DateTime.now().millisecondsSinceEpoch}.webm',
    ]);
    FileUtil().write(path, base64Decode(data));
    launchUrlString(path);
  }
}
