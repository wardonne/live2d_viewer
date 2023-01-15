import 'package:live2d_viewer/constants/registry.dart';
import 'package:win32_registry/win32_registry.dart';

class RegistryUtil {
  static void init() {
    final RegistryKey registryKey = Registry.openPath(RegistryHive.currentUser,
        path: RegistryKeys.softwareKey);
    if (exists(RegistryPaths.appRegistryPath)) return;
    registryKey.createKey(RegistryKeys.appKey);
  }

  static bool exists(String path) {
    final parts = path.split('\\');
    final RegistryKey key = Registry.openPath(
      RegistryHive.currentUser,
      path: parts.take(parts.length - 1).join("\\"),
    );
    return key.subkeyNames.where((element) => element == parts.last).isNotEmpty;
  }

  static void create({
    required String path,
    required String name,
    required RegistryValueType type,
    required Object data,
  }) {
    RegistryKey registryKey = Registry.openPath(
      RegistryHive.currentUser,
      path: RegistryPaths.appRegistryPath,
    );
    path.split('\\').forEach((key) {
      registryKey = registryKey.createKey(key);
    });
    registryKey.createValue(RegistryValue(name, type, data));
  }

  static Object? get({
    required String path,
    required String name,
    Object? defaultValue,
  }) {
    final RegistryKey registryKey = Registry.openPath(
      RegistryHive.currentUser,
      path: path,
    );
    return registryKey.getValue(name)?.data ?? defaultValue;
  }
}
