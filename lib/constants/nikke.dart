import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/utils/utils.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class NikkeConstants {
  static const menuName = 'Nikke';

  static String snapshotPath = p.join('Live2DViewer', 'Nikke');

  static const String assetsURL = '${ApplicationConstants.assetsURL}/nikke';
  static const String characterDataURL = '$assetsURL/character/data.json';

  static String resourceCachePath =
      PathUtil().join([ApplicationConstants.resourceCachePath, 'nikke']);
  static String screenshotPath =
      PathUtil().join([ApplicationConstants.screenshotPath, 'nikke']);
}
