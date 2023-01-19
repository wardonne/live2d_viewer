import 'package:live2d_viewer/constants/registry.dart';
import 'package:win32_registry/win32_registry.dart';

class RegistryUtil {
  static void init() {
    final RegistryKey registryKey = Registry.openPath(RegistryHive.currentUser,
        path: RegistryKeys.software);
    if (registryKey.subkeyNames
        .where((element) => element == RegistryKeys.app)
        .isEmpty) {
      registryKey.createKey(RegistryKeys.app);
    }
  }

  static bool exists(String path) {
    final parts = path.split('\\');
    final RegistryKey key = Registry.openPath(
      RegistryHive.currentUser,
      path: parts.take(parts.length - 1).join('\\'),
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
      path: RegistryPaths.app,
    );
    final currentPath = <String>[];
    path.split('\\').forEach((key) {
      currentPath.add(path);
      if (!exists(currentPath.join('\\'))) {
        registryKey = registryKey.createKey(key);
      } else {
        registryKey = Registry.openPath(RegistryHive.currentUser,
            path: currentPath.join('\\'));
      }
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
