import 'package:flutter/cupertino.dart';
import 'package:live2d_viewer/models/destiny_child/character.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/services/destiny_child/character_service.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';

class CharacterGrid extends StatelessWidget {
  final List<Character> items;
  final DestinyChildSettings destinyChildSettings;
  const CharacterGrid({
    super.key,
    required this.items,
    required this.destinyChildSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: items.where((item) => item.enable).map((item) {
        final avatarPath = destinyChildSettings.characterSettings!.avatarPath;
        return Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(8),
          child: ImageButton.fromFile(
            filepath: '$avatarPath/${item.avatar}',
            onPressed: () {
              CharacterService.initViewWindow(item);
              DestinyChildService.closeItemsWindow();
            },
          ),
        );
      }).toList(),
    );
  }
}
