import 'dart:io';

import 'package:live2d_viewer/constants/constants.dart';

class FfmpegUtil {
  final String ffmpeg = Tools.ffmpeg;

  Future<ProcessResult> convert(String input, String output) async {
    return Process.run(
      ffmpeg,
      [
        '-i',
        input,
        '-vf',
        'pad="ceil(iw/2)*2:ceil(ih/2)*2"',
        output,
        '-y',
      ],
    );
  }
}
