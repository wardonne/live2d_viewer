import 'package:live2d_viewer/controllers/visible_controller.dart';

class VisiblePopupMenuController<T> extends VisibleController {
  List<T> items;
  VisiblePopupMenuController({super.visible, required this.items});

  setData(List<T> items) {
    this.items = items;
    visible = true;
    notifyListeners();
  }
}
