import 'package:live2d_viewer/constants/controllers.dart';

class AppService extends Object {
  static void unextendSidebar() {
    if (sideBarController.extended) {
      sideBarController.setExtended(false);
    }
  }
}
