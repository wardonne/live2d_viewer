import 'package:live2d_viewer/constants/application.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

class NikkeConstants {
  static const menuName = 'Nikke';

  static String snapshotPath = p.join('Live2DViewer', 'Nikke');

  static const String assetsURL = '${ApplicationConstants.assetsURL}/nikke';
  static const String characterDataURL = '$assetsURL/character/data.json';

  static String resourceCachePath =
      p.join(ApplicationConstants.resourceCachePath, 'nikke');
}
