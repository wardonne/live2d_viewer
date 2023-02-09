import 'package:flutter/material.dart';

class LoadController extends ChangeNotifier {
  bool _load = false;
  bool _reload = false;

  bool get load => _load;

  set load(bool value) {
    if (_load == value) return;
    _load = value;
    if (value) {
      notifyListeners();
    }
  }

  bool get reload => _reload;

  set reload(bool value) {
    if (_reload == value) return;
    _reload = value;
    if (_reload) {
      _load = true;
      notifyListeners();
    }
  }
}
