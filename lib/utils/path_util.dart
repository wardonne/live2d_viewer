// ignore_for_file: depend_on_referenced_packages

import 'package:live2d_viewer/constants/constants.dart';
import 'package:path/path.dart' as p;

class PathUtil {
  String join(List<String> parts) {
    return p.joinAll(parts);
  }

  String relative(String path, String from) {
    return p.relative(path, from: from);
  }

  Uri localAssetsUrl(String path) {
    return Uri(
      scheme: ApplicationConstants.localAssetsURL.scheme,
      host: ApplicationConstants.localAssetsURL.host,
      path: Uri.parse(relative(
        path,
        ApplicationConstants.rootPath,
      )).path,
    );
  }

  String parent(String path, {String seq = '/'}) {
    final parts = path.split(seq);
    parts.removeLast();
    return parts.join(seq);
  }
}
