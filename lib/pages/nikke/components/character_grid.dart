import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/settings/nikke_settings.dart';
import 'package:live2d_viewer/services/app_service.dart';
import 'package:live2d_viewer/services/nikke/character_service.dart';
import 'package:live2d_viewer/services/nikke/nikke_service.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';

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
        return ContainerButton(
          width: 100,
          padding: const EdgeInsets.all(10),
          onClick: () => _detail(item),
          backgroundColor: Colors.transparent,
          hoverBackgroundColor: Colors.white12,
          child: Column(
            children: [
              Center(child: Image.file(File('$avatarPath/${item.avatar}'))),
              const Divider(height: 2, color: Colors.transparent),
              Center(child: Text(item.name))
            ],
          ),
        );
      }).toList(),
    );
  }

  _detail(Character item) {
    CharacterService.initViewWindow(item);
    AppService.unextendSidebar();
    NikkeService.closeItemsWindow();
  }
}
