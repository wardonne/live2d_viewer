import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/pages/destiny_child/components/character_grid.dart';
import 'package:live2d_viewer/pages/destiny_child/components/character_table.dart';
import 'package:live2d_viewer/controllers/edit_mode_controller.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/destiny_child/character_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';

class CharacterTabView extends StatelessWidget {
  final EditModeController editModeController =
      DestinyChildConstants.characterEditModeController;

  CharacterTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final destinyChildSettings = watchProvider<SettingsProvider>(context)
        .settings!
        .destinyChildSettings!;
    final items = CharacterService(destinyChildSettings).load();
    return AnimatedBuilder(
      animation: editModeController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: editModeController.isEditMode
                ? CharacterTable(
                    source: CharacterTableSource(
                      items: items,
                      destinyChildSettings: destinyChildSettings,
                    ),
                  )
                : CharacterGrid(
                    items: items,
                    destinyChildSettings: destinyChildSettings,
                  ),
          ),
        );
      },
    );
  }
}
