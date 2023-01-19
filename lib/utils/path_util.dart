// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart' as p;

class PathUtil {
  String join(List<String> parts) {
    return p.joinAll(parts);
  }

  String relative(String path, String from) {
    return p.relative(path, from: from);
  }
}
