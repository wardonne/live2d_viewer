import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:live2d_viewer/constants/nikke.dart';
import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/settings/nikke_settings.dart';

class NikkeService {
  final NikkeSettings nikkeSettings;

  NikkeService(this.nikkeSettings);

  static void openItemsWindow() => NikkeConstants.itemListController.show();

  static void closeItemsWindow() => NikkeConstants.itemListController.hidden();

  static Future<List<Character>> characters() async {
    final content =
        await rootBundle.loadString(ResourceConstants.nikkeCharacterJson);
    return (jsonDecode(content) as List)
        .map((item) => Character.fromJson(item))
        .toList();
  }
}
