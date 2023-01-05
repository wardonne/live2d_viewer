import 'package:flutter/material.dart';
import 'package:live2d_viewer/pages/nikke/components/character_view.dart';

class ActionPopupMenu extends StatelessWidget {
  final CharacterViewController controller;
  const ActionPopupMenu({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      splashRadius: 20,
      tooltip: 'show actions',
      child: const Icon(Icons.motion_photos_auto, size: 20),
      itemBuilder: (context) => controller.selectedSkin.actions
          .map((action) => PopupMenuItem(
                height: 15,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(action.name),
                ),
                onTap: () {
                  controller.setAction(action.name);
                },
              ))
          .toList(),
    );
  }
}
