import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/pages/destiny_child/components/child_grid.dart';
import 'package:live2d_viewer/pages/destiny_child/components/child_table.dart';
import 'package:live2d_viewer/pages/destiny_child/controllers/edit_mode_controller.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/destiny_child/child_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';

class ChildTabView extends StatelessWidget {
  final EditModeController editModeController =
      DestinyChildConstant.childEditModeController;

  ChildTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final destinyChildSettings = watchProvider<SettingsProvider>(context)
        .settings!
        .destinyChildSettings!;
    final children = ChildService(destinyChildSettings).load();
    return AnimatedBuilder(
      animation: editModeController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: editModeController.isEditMode
                ? ChildTable()
                : ChildGrid(
                    children: children,
                    destinyChildSettings: destinyChildSettings,
                  ),
          ),
        );
      },
    );
  }
}
