import 'package:hotkey_manager/hotkey_manager.dart';

class HotKeys {
  static HotKey fullscreen = HotKey(
    KeyCode.f11,
    scope: HotKeyScope.inapp,
  );

  static HotKey find = HotKey(
    KeyCode.keyF,
    modifiers: [KeyModifier.control],
    scope: HotKeyScope.inapp,
  );

  static HotKey enter = HotKey(
    KeyCode.enter,
    scope: HotKeyScope.inapp,
  );
}
