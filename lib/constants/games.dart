import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/game.dart';

class Games {
  static Game destinyChild = Game(
    name: DestinyChildConstants.name,
    icon: ResourceConstants.destinyChildIcon,
    route: Routes.destinyChild,
  );

  static Game nikke = Game(
    name: NikkeConstants.name,
    icon: ResourceConstants.nikkeIcon,
    route: Routes.nikke,
  );

  static Game girlFrontline = Game(
    name: GirlFrontlineConstants.name,
    icon: ResourceConstants.girlFrontlineIcon,
    route: Routes.girlFrontline,
  );

  static List<Game> get list => [
        destinyChild,
        nikke,
        girlFrontline,
      ];
}
