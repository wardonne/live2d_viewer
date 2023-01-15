import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

class HashUtil {
  String hashMd5(String data) {
    Uint8List content = const Utf8Encoder().convert(data);
    return md5.convert(content).toString();
  }
}
