import 'package:flutter/cupertino.dart';
import 'package:live2d_viewer/constants/routes.dart' as routes;
import 'package:live2d_viewer/pages/destiny_child/index.dart';
import 'package:live2d_viewer/pages/index.dart';
import 'package:live2d_viewer/pages/nikke/character_list.dart';
import 'package:live2d_viewer/pages/nikke/nikke.dart';

var router = <String, WidgetBuilder>{
  routes.Routes.index: (context) => IndexPage(),
  routes.Routes.destinyChild: (context) => const DestinyChildPage(),
  routes.Routes.nikke: (context) => const NikkePage(),
  routes.Routes.nikkeCharacters: (context) => const CharacterList(),
  routes.Routes.nikkeCharacterDetail: (context) => const CharacterDetail(),
};
