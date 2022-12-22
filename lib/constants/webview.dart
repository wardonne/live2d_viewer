import 'dart:io';

import 'package:flutter/foundation.dart';

class WebviewConstant {
  static String defaultVirtualHost = 'assets.webview';
  static String defaultPath = kDebugMode
      ? '${Directory.current.path}/assets/webview'
      : '${Directory.current.path}/data/flutter_assets/assets/webview';
}
