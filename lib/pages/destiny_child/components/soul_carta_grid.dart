import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/settings/destiny_child_settings.dart';
import 'package:live2d_viewer/models/destiny_child/soul_carta.dart';
import 'package:live2d_viewer/services/destiny_child/destiny_child_service.dart';
import 'package:live2d_viewer/services/destiny_child/soul_carta_service.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';

class SoulCartaGrid extends StatelessWidget {
  final List<SoulCarta> soulCartas;
  final DestinyChildSettings destinyChildSettings;
  final SoulCartaService soulCartaService;
  SoulCartaGrid({
    super.key,
    required this.soulCartas,
    required this.destinyChildSettings,
  }) : soulCartaService = SoulCartaService(destinyChildSettings);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: soulCartas.map((soulCarta) {
        return Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(5),
          child: ImageButton.fromFile(
            filepath:
                '${destinyChildSettings.soulCartaSettings!.avatarPath}/${soulCarta.avatar}',
            onPressed: () {
              DestinyChildService.closeItemsWindow();
              soulCartaService.initViewWindow(
                useLive2d: soulCarta.useLive2d,
                data: soulCarta,
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
