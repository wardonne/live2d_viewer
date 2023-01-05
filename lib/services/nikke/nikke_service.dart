import 'package:live2d_viewer/constants/nikke.dart';
import 'package:live2d_viewer/models/settings/nikke_settings.dart';

class NikkeService {
  final NikkeSettings nikkeSettings;

  NikkeService(this.nikkeSettings);

  static void openItemsWindow() => NikkeConstants.itemListController.show();

  static void closeItemsWindow() => NikkeConstants.itemListController.hidden();
}
