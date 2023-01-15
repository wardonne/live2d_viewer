import 'package:live2d_viewer/constants/application.dart';

class RegistryKeys {
  static const softwareKey = 'Software';
  static const appKey = ApplicationConstants.appName;
}

class RegistryNames {
  static const initedName = 'Inited';
}

class RegistryPaths {
  static const appRegistryPath =
      '${RegistryKeys.softwareKey}\\${RegistryKeys.appKey}';
}
