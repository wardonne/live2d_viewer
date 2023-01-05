import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/settings/nikke_settings.dart';
import 'package:live2d_viewer/services/app_service.dart';
import 'package:live2d_viewer/services/nikke/character_service.dart';
import 'package:live2d_viewer/services/nikke/nikke_service.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';

class CharacterGrid extends StatelessWidget {
  final List<Character> items;
  final NikkeSettings nikkeSettings;

  const CharacterGrid({
    super.key,
    required this.items,
    required this.nikkeSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: items.where((item) => item.enable).map((item) {
        final avatarPath = nikkeSettings.characterSettings!.avatarPath;
        return Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white70, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: ImageButton.fromFile(
              filepath: '$avatarPath/${item.avatar}',
              onPressed: () {
                CharacterService.initViewWindow(item);
                AppService.unextendSidebar();
                NikkeService.closeItemsWindow();
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
