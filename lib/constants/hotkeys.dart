import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

class HotKeys {
  static HotKey fullscreen = HotKey(
    key: PhysicalKeyboardKey.f11,
    scope: HotKeyScope.inapp,
  );

  static HotKey find = HotKey(
    key: PhysicalKeyboardKey.keyF,
    modifiers: [HotKeyModifier.control],
    scope: HotKeyScope.inapp,
  );

  static HotKey enter = HotKey(
    key: PhysicalKeyboardKey.enter,
    scope: HotKeyScope.inapp,
  );
}
