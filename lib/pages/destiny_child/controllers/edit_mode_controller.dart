import 'package:flutter/material.dart';

class EditModeController extends ChangeNotifier {
  bool _isEditMode;

  EditModeController({required bool isEditMode}) : _isEditMode = isEditMode;

  EditModeController.enable() : _isEditMode = true;

  EditModeController.disable() : _isEditMode = false;

  set isEditMode(bool isEditMode) {
    if (_isEditMode != isEditMode) {
      _isEditMode = isEditMode;
      notifyListeners();
    }
  }

  bool get isEditMode => _isEditMode;

  void toggleEidtMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }
}
