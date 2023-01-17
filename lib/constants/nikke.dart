import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/utils/utils.dart';

class NikkeConstants {
  static const String assetsURL = '${ApplicationConstants.assetsURL}/nikke';
  static const String characterDataURL = '$assetsURL/character/data.json';
  static const String characterSpineURL =
      '${NikkeConstants.assetsURL}/character/spine';
  static const String characterAvatarURL =
      '${NikkeConstants.assetsURL}/character/avatars';

  static String resourceCachePath =
      PathUtil().join([ApplicationConstants.resourceCachePath, 'nikke']);
  static String screenshotPath =
      PathUtil().join([ApplicationConstants.screenshotPath, 'nikke']);
}
