import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/utils/path_util.dart';

class GirlFrontlineConstants {
  static const String name = 'girlFrontline';

  static const String assetsURL =
      '${ApplicationConstants.assetsURL}/girl-frontline';
  static const String characterDataURL = '$assetsURL/character/data.json';
  static const String characterAvatarURL = '$assetsURL/character/avatars';
  static const String characterImageURL = '$assetsURL/character/images';
  static const String characterSpineURL = '$assetsURL/character/spine';
  static const String characterLive2DURL = '$assetsURL/character/live2d';

  static String screenshotPath =
      PathUtil().join([ApplicationConstants.screenshotPath, 'girl-frontline']);
}
