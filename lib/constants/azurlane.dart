import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/enum/ship_rarity.dart';
import 'package:live2d_viewer/utils/path_util.dart';

class AzurlaneConstants {
  static const String name = 'azurlane';

  static const String assetsURL = '${ApplicationConstants.assetsURL}/azurlane';
  static const String characterDataURL = '$assetsURL/character/data.json';
  static const String characterAvatarURL = '$assetsURL/character/avatars';
  static const String characterLive2DURL = '$assetsURL/character/live2d';
  static const String characterPaintingURL = '$assetsURL/character/paintings';
  static const String characterPaintingFaceURL =
      '$assetsURL/character/paintingfaces';
  static const String characterFaceRectURL = '$assetsURL/character/face_rects';
  static const String characterSpineURL = '$assetsURL/character/spine';
  static const String characterSpinePaintingURL =
      '$assetsURL/character/spinepainting';

  static String screenshotPath =
      PathUtil().join([ApplicationConstants.screenshotPath, 'azurlane']);

  static String cachedFacePaintingPath = PathUtil().join([
    ApplicationConstants.cachePath,
    name,
  ]);

  static const String defaultSDAnimation = 'stand';

  static const raritys = {
    2: ShipRarity.rarity2,
    3: ShipRarity.rarity3,
    4: ShipRarity.rarity4,
    5: ShipRarity.rarity5,
    6: ShipRarity.rarity6,
    7: ShipRarity.rarity7,
    8: ShipRarity.rarity8,
    14: ShipRarity.rarity14,
    15: ShipRarity.rarity15,
  };
}
