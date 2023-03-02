import 'package:flutter/material.dart';

class VisibleController extends ChangeNotifier {
  bool visible;

  VisibleController({
    this.visible = true,
  });

  hide() {
    if (visible) {
      visible = false;
      notifyListeners();
    }
  }

  show() {
    if (!visible) {
      visible = true;
      notifyListeners();
    }
  }

  toggle() {
    visible = !visible;
    notifyListeners();
  }
}
