import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/destiny_child/soul_carta_model.dart';
import 'package:live2d_viewer/pages/destiny_child/components/components.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';

class SoulCartaCard extends StatelessWidget {
  final SoulCartaModel soulCarta;
  const SoulCartaCard({super.key, required this.soulCarta});

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
          SoulCartaAvatar(
              avatar:
                  '${DestinyChildConstants.soulCartaAvatarURL}/${soulCarta.avatar}'),
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
