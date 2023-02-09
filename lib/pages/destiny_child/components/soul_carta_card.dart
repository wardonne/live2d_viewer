import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/controllers/load_controller.dart';
import 'package:live2d_viewer/models/destiny_child/soul_carta_model.dart';
import 'package:live2d_viewer/pages/destiny_child/components/components.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SoulCartaCard extends StatelessWidget {
  final SoulCartaModel soulCarta;
  SoulCartaCard({super.key, required this.soulCarta});

  final loadController = LoadController();

  @override
  Widget build(BuildContext context) {
    return ContainerButton(
      width: 100,
      padding: const EdgeInsets.all(10.0),
      backgroundColor: Colors.transparent,
      hoverBackgroundColor: Styles.hoverBackgroundColor,
      onClick: () => Navigator.pushNamed(
        context,
        Routes.destinyChildSoulCartaDetail,
        arguments: soulCarta,
      ),
      child: Column(
        children: [
          VisibilityDetector(
            key: ObjectKey(soulCarta),
            child: SoulCartaAvatar(
              avatar:
                  '${DestinyChildConstants.soulCartaAvatarURL}/${soulCarta.avatar}',
              controller: loadController,
            ),
            onVisibilityChanged: (info) => loadController.load = true,
          ),
          const Divider(
            height: 2,
            color: Colors.transparent,
          ),
          Center(
            child: Text(soulCarta.name),
          ),
        ],
      ),
    );
  }
}
