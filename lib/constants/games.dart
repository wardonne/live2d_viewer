import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/constants/routes.dart';
import 'package:live2d_viewer/models/game.dart' as model_game;

class Games {
  static model_game.Game destinyChild = model_game.Game(
    name: 'destinyChild',
    icon: ResourceConstants.destinyChildIcon,
    route: Routes.destinyChild,
  );

  static model_game.Game nikke = model_game.Game(
    name: 'nikke',
    icon: ResourceConstants.nikkeIcon,
    route: Routes.nikke,
  );

  static List<model_game.Game> get list => [
        destinyChild,
        nikke,
      ];
}
