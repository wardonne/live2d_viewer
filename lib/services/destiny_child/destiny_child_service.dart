import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';

class DestinyChildService {
  final DestinyChildSettings destinyChildSettings;

  DestinyChildService(this.destinyChildSettings);

  static void openItemsWindow() {
    DestinyChildConstant.exhibitionWindowController.show();
  }

  static void closeItemsWindow() {
    DestinyChildConstant.exhibitionWindowController.hidden();
  }
}
