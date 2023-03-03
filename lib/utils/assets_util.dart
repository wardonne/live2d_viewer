import 'package:flutter/services.dart';

class AssetsUtil {
  Future<String> loadString(String key,
      {bool cache = true, bool reload = false}) {
    if (reload) {
      rootBundle.evict(key);
    }
    return rootBundle.loadString(key, cache: cache);
  }
}
