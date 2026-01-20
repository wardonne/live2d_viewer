import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/utils/path_util.dart';
// ignore: depend_on_referenced_packages

class DestinyChildConstants {
  static const String name = 'destinyChild';

  static const String assetsURL =
      'https://raw.githubusercontent.com/wardonne/destinychild-resource/refs/heads/main';
  static const String characterDataURL = '$assetsURL/character/data.json';
  static const String characterAvatarURL = '$assetsURL/character/avatars';
  static const String characterLive2DURL = '$assetsURL/character/live2d';

  static const String soulCartaDataURL = '$assetsURL/soul_carta/data.json';
  static const String soulCartaAvatarURL = '$assetsURL/soul_carta/avatars';
  static const String soulCartaImageURL = '$assetsURL/soul_carta/images';
  static const String soulCartaLive2DURL = '$assetsURL/soul_carta/live2d';

  static String screenshotPath =
      PathUtil().join([ApplicationConstants.screenshotPath, 'destiny_child']);

  static const String modelJSONFormat = 'character.DRAGME.%s.json';
}
