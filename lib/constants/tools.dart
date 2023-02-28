import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/utils/utils.dart';

class Tools {
  static String ffmpeg = PathUtil().join([
    ApplicationConstants.rootPath,
    'bin',
    'ffmpeg.exe',
  ]);
}
