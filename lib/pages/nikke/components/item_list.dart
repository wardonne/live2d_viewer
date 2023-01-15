import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/constants/nikke.dart';
import 'package:live2d_viewer/controllers/edit_mode_controller.dart';
import 'package:live2d_viewer/pages/nikke/components/character_grid.dart';
import 'package:live2d_viewer/pages/nikke/components/character_table.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/nikke/character_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:live2d_viewer/widget/wrappers/visible_wrapper.dart';

class ItemList extends StatelessWidget {
  final EditModeController _controller =
      NikkeConstants.characterEditModeController;

  ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final nikkeSettings =
        watchProvider<SettingsProvider>(context).settings!.nikkeSettings!;
    final items = CharacterService(nikkeSettings).load();
    return VisibleWrapper(
      controller: NikkeConstants.itemListController,
      child: Column(
        children: [
          Toolbar.header(
            height: headerBarHeight,
            color: toolbarColor,
            title: const Center(
              child: Text('Nikke'),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => _controller.isEditMode
                      ? CharacterTable(
                          source: CharacterTableSource(
                            items: items,
                            nikkeSettings: nikkeSettings,
                          ),
                        )
                      : CharacterGrid(
                          items: items.where((item) => item.enable).toList(),
                          nikkeSettings: nikkeSettings,
                        ),
                ),
              ),
            ),
          ),
          Toolbar.footer(
            height: footerBarHeight,
            color: toolbarColor,
            endActions: [
              AnimatedBuilder(
                animation: NikkeConstants.characterEditModeController,
                builder: (context, child) {
                  final isEditMode =
                      NikkeConstants.characterEditModeController.isEditMode;
                  return ImageButton(
                    icon: Icon(
                      isEditMode ? Icons.grid_view : Icons.table_view,
                      size: 20,
                    ),
                    onPressed: () => NikkeConstants.characterEditModeController
                        .toggleEidtMode(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
