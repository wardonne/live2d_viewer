import 'package:flutter/foundation.dart';
import 'package:live2d_viewer/models/settings/settings.dart';

class SettingsProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Settings? _settings;

  Settings? get settings => _settings;

  SettingsProvider({required Settings settings}) : _settings = settings {
    notifyListeners();
  }

  void changeSettings(Settings settings) {
    if (_settings != settings) {
      _settings = settings;
      notifyListeners();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('settings', _settings));
  }

  Future<void> updateSettings() async {
    await _settings?.updateSettings();
    notifyListeners();
  }
}
