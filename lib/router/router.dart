import 'package:flutter/cupertino.dart';
import 'package:live2d_viewer/constants/routes.dart' as routes;
import 'package:live2d_viewer/pages/azurlane/azurlane.dart' as azurlane;
import 'package:live2d_viewer/pages/destiny_child/destiny_child.dart'
    as destiny_child;
import 'package:live2d_viewer/pages/index.dart';
import 'package:live2d_viewer/pages/nikke/nikke.dart' as nikke;
import 'package:live2d_viewer/pages/girl_frontline/girl_frontline.dart'
    as girl_frontline;

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

  // girl-frontline
  routes.Routes.girlFrontline: (context) =>
      const girl_frontline.GirlFrontlinePage(),
  routes.Routes.girlFrontlineCharacterDetail: (context) =>
      const girl_frontline.CharacterDetail(),

  // azurlane
  routes.Routes.azurlane: (context) => const azurlane.AzurlanePage(),
  routes.Routes.azurlaneCharacterDetail: (context) =>
      const azurlane.CharacterDetail(),
};
