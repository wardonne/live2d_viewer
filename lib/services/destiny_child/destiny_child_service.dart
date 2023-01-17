import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/models/destiny_child/character.dart';
import 'package:live2d_viewer/models/destiny_child/soul_carta.dart';
import 'package:live2d_viewer/services/cache_service.dart';

class DestinyChildService {
  DestinyChildService();

  static void openItemsWindow() {
    DestinyChildConstants.itemListController.show();
  }

  static void closeItemsWindow() {
    DestinyChildConstants.itemListController.hidden();
  }

  final cache = CacheService();

  Future<List<Character>> characters() async {
    const url = DestinyChildConstants.characterDataURL;
    final cachedHttpResponse = cache.getCachedHttpResponse(path: url);
    List<dynamic> list = [];
    if (cache.isUsable(cachedHttpResponse, duration: const Duration(days: 1))) {
      list = jsonDecode(cachedHttpResponse.readAsStringSync());
    } else {
      final response = await Dio().get<List>(url);
      list = response.data ?? [];
      final bytes = Int32List.fromList(utf8.encode(jsonEncode(list)));
      cache.cacheHttpResponse(bytes: bytes, path: url);
    }
    return list.map((item) => Character.fromJson(item)).toList();
  }

  Future<List<SoulCarta>> soulCartas() async {
    const url = DestinyChildConstants.soulCartaDataURL;
    final cachedHttpResponse = cache.getCachedHttpResponse(path: url);
    List<dynamic> list = [];
    if (cache.isUsable(cachedHttpResponse, duration: const Duration(days: 1))) {
      list = jsonDecode(cachedHttpResponse.readAsStringSync());
    } else {
      final response = await Dio().get<List>(url);
      list = response.data ?? [];
      final bytes = Int32List.fromList(utf8.encode(jsonEncode(list)));
      cache.cacheHttpResponse(bytes: bytes);
    }
    return list.map((item) => SoulCarta.fromJson(item)).toList();
  }
}
