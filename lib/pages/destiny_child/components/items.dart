import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/constants/settings.dart';
import 'package:live2d_viewer/pages/destiny_child/controllers/edit_mode_controller.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:live2d_viewer/widget/wrappers/colored_tabbar_wrapper.dart';

class ItemList extends StatelessWidget {
  final ExhibitionWindowController _exhibitionWindowController =
      DestinyChildConstant.exhibitionWindowController;

  final TabController tabController;
  ItemList({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _exhibitionWindowController,
      builder: (context, child) {
        return Visibility(
          visible: _exhibitionWindowController.visible,
          child: Column(
            children: [
              ColoredTabBarWrapper(
                tabBar: TabBar(
                  indicator: const BoxDecoration(
                    color: Colors.black54,
                  ),
                  controller: tabController,
                  tabs: DestinyChildConstant.tabbars,
                ),
                color: barColor,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: DestinyChildConstant.tabviews
                      .map((e) => e(context))
                      .toList(),
                ),
              ),
              Toolbar.footer(
                height: footerBarHeight,
                color: barColor,
                endActions: [
                  _editModeSwitch(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _editModeSwitch() {
    var controller = _getEditModeControllerByIndex(tabController.index);
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, child) {
        var isEditMode = controller.isEditMode;
        return ImageButton.fromIcon(
            icon: isEditMode ? Icons.grid_view : Icons.table_view,
            onPressed: () {
              controller.toggleEidtMode();
            });
      },
    );
  }

  EditModeController? _getEditModeControllerByIndex(int index) {
    return DestinyChildConstant.indexedEditModeController[index];
  }
}

class ExhibitionWindowController extends ChangeNotifier {
  bool visible;

  ExhibitionWindowController({
    this.visible = true,
  });

  hidden() {
    if (visible) {
      visible = false;
      notifyListeners();
    }
  }

  show() {
    if (!visible) {
      visible = true;
      notifyListeners();
    }
  }
}