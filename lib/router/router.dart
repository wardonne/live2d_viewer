import 'package:flutter/cupertino.dart';
import 'package:live2d_viewer/constants/routes.dart' as routes;
import 'package:live2d_viewer/pages/destiny_child/destiny_child.dart'
    as destiny_child;
import 'package:live2d_viewer/pages/index.dart';
import 'package:live2d_viewer/pages/nikke/nikke.dart' as nikke;

var router = <String, WidgetBuilder>{
  routes.Routes.index: (context) => const IndexPage(),
  // destiny-child
  routes.Routes.destinyChild: (context) =>
      const destiny_child.DestinyChildPage(),
  // routes.Routes.destinyChildCharacters: (context) =>
  //     const destiny_child.CharacterList(),
  routes.Routes.destinyChildCharacterDetail: (context) =>
      const destiny_child.CharacterDetail(),
  routes.Routes.destinyChildSoulCartaDetail: (context) =>
      const destiny_child.SoulCartaDetail(),
  // nikke
  routes.Routes.nikke: (context) => const nikke.NikkePage(),
  routes.Routes.nikkeCharacters: (context) => const nikke.CharacterList(),
  routes.Routes.nikkeCharacterDetail: (context) =>
      const nikke.CharacterDetail(),
};
