import 'package:flutter/cupertino.dart';
import 'package:live2d_viewer/constants/routes.dart';
import 'package:live2d_viewer/pages/destiny_child/index.dart';
import 'package:live2d_viewer/pages/index.dart';

var routes = <String, WidgetBuilder>{
  index: (context) => IndexPage(),
  destinyChild: (context) => const DestinyChildPage(),
};
