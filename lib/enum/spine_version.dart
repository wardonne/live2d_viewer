import 'dart:core';

import 'package:live2d_viewer/constants/constants.dart';

enum SpineVersion {
  spine40(resource: ResourceConstants.spineVersion40Html),
  spine2127(resource: ResourceConstants.spineVersion2127Html);

  final String resource;
  const SpineVersion({required this.resource});
}
