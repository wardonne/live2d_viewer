import 'dart:convert';
import 'dart:io';

class BackupService extends Object {
  final String path;
  List<String> _backups = [];

  BackupService(this.path) {
    final file = File(path);
    if (file.existsSync()) {
      final content = file.readAsStringSync();
      final items = jsonDecode(content);
      for (final item in items) {
        _backups.add(item as String);
      }
    }
  }

  File get latest => File(_backups.last);

  File? get latestExists {
    for (final item in _backups.reversed) {
      final file = File(item);
      if (file.existsSync()) {
        return file;
      }
    }
    return null;
  }

  void add(String path) {
    _backups.add(path);
    if (_backups.length >= 10) {
      _backups.removeAt(0);
    }
    _save();
  }

  void clear() {
    _backups = [];
    _save();
  }

  void _save() {
    var encoder = const JsonEncoder.withIndent('  ');
    var content = encoder.convert(_backups);
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync(content);
  }
}
