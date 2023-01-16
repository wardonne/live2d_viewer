import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/models/destiny_child/character.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class SkinList extends StatelessWidget {
  final List<Skin> skins;
  const SkinList({
    super.key,
    required this.skins,
  });

  @override
  Widget build(BuildContext context) {
    final characterViewController =
        DestinyChildConstants.characterViewController;
    final selectedIndex = characterViewController.selectedIndex;
    final avatarPath = Provider.of<SettingsProvider>(context)
        .settings!
        .destinyChildSettings!
        .characterSettings!
        .avatarPath;
    return Visibility(
      visible: skins.length > 1,
      child: Container(
        width: 80,
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.white70,
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.transparent,
                child: ListView.separated(
                  padding: const EdgeInsets.all(5),
                  itemCount: skins.length,
                  itemBuilder: (context, index) {
                    var skin = skins[index];
                    return ListTile(
                      leading: Image.file(
                        File('$avatarPath/${skin.avatar}'),
                      ),
                      textColor: Colors.white70,
                      contentPadding: const EdgeInsets.all(5),
                      selected: index == selectedIndex,
                      selectedColor: Colors.white,
                      selectedTileColor: Colors.black38,
                      hoverColor: Colors.black38,
                      mouseCursor: SystemMouseCursors.click,
                      onTap: () {
                        characterViewController.selectSkin(index);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.white24,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
