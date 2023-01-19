import 'package:live2d_viewer/constants/application.dart';

class RegistryKeys {
  static const software = 'Software';
  static const app = ApplicationConstants.appName;
  static const destinyChild = 'Destiny Child';
  static const nikke = 'Nikke';

  static const character = 'Character';
  static const soulCarta = 'Soul Carta';
}

class RegistryNames {
  static const initedName = 'Inited';
  static const versionName = 'Version';
}

class RegistryPaths {
  static const app = '${RegistryKeys.software}\\${RegistryKeys.app}';
  static const destinyChild = '$app\\${RegistryKeys.destinyChild}';
  static const destinyChildCharacter =
      '$destinyChild\\${RegistryKeys.character}';
  static const destinyChildSoulCarta =
      '$destinyChild\\${RegistryKeys.soulCarta}';
  static const nikke = '$destinyChild\\${RegistryKeys.nikke}';
  static const nikkeCharacter = '$nikke\\${RegistryKeys.character}';

  static const all = [
    app,
    destinyChild,
    destinyChildCharacter,
    destinyChildSoulCarta,
    nikke,
    nikkeCharacter,
  ];
}
