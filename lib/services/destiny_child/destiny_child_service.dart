import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';

class DestinyChildService {
  final DestinyChildSettings destinyChildSettings;

  DestinyChildService(this.destinyChildSettings);

  static void openItemsWindow() {
    DestinyChildConstants.itemListController.show();
  }

  static void closeItemsWindow() {
    DestinyChildConstants.itemListController.hidden();
  }
}
