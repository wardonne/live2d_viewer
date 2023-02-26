import 'dart:io';

class FileUtil {
  bool exists(String path) {
    return File(path).existsSync();
  }

  String read(String path) {
    return File(path).readAsStringSync();
  }

  void write(String path, List<int> content) {
    final file = File(path);
    return writeFile(file, content);
  }

  void writeFile(File file, List<int> content) {
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    return file.writeAsBytesSync(content);
  }
}
