import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

class WebviewConstant {
  static String defaultVirtualHost = 'assets.webview';
  static String defaultPath = kDebugMode
      ? p.join(Directory.current.path, 'assets', 'webview')
      : p.join(Directory.current.path, 'data', 'flutter_assets', 'assets',
          'webview');
}
