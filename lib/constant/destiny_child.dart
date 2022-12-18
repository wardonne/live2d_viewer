import 'dart:io';

import 'package:flutter/foundation.dart';

class DestinyChildConstant {
  static const String defaultLive2DVersion = '2';

  static String assetsPath = kDebugMode
      ? 'assets/destiny_child'
      : 'data/flutter_assets/assets/destiny_child';
  static const String defaultSoulCartaVirtualHost = 'assets.soul_carta.dc';
  static String defaultSoulCartaPath =
      '${Directory.current.path}/$assetsPath/soul_carta';
  static String defaultSoulCartaDataPath = '$defaultSoulCartaPath/data.json';

  static const String defaultChildVirtualHost = 'assets.child.dc';
  static String defaultChildPath =
      '${Directory.current.path}/$assetsPath/child';
  static String defaultChildDataPath = '$defaultChildPath/data.json';
}
