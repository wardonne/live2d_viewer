import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/controllers/edit_mode_controller.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:live2d_viewer/widget/wrappers/colored_tabbar_wrapper.dart';
import 'package:live2d_viewer/widget/wrappers/visible_wrapper.dart';

class ItemList extends StatelessWidget {
  final VisibleController _itemListController =
      DestinyChildConstants.itemListController;

  final TabController tabController;
  ItemList({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return VisibleWrapper(
      controller: _itemListController,
      child: Column(
        children: [
          ColoredTabBarWrapper(
            tabBar: TabBar(
              indicator: const BoxDecoration(
                color: Colors.black54,
              ),
              controller: tabController,
              tabs: DestinyChildConstants.tabbars,
            ),
            color: barColor,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: DestinyChildConstants.tabviews
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
  }

  _editModeSwitch() {
    var controller = _getEditModeControllerByIndex(tabController.index);
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, child) {
        var isEditMode = controller.isEditMode;
        return ImageButton(
            icon: Icon(
              isEditMode ? Icons.grid_view : Icons.table_view,
              size: 20,
              color: Colors.white70,
            ),
            onPressed: () {
              controller.toggleEidtMode();
            });
      },
    );
  }

  EditModeController? _getEditModeControllerByIndex(int index) {
    return DestinyChildConstants.indexedEditModeController[index];
  }
}
