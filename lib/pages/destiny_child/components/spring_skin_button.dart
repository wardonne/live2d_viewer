import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/destiny_child/character_model.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';

class SpringSkinButton extends StatefulWidget {
  final CharacterModel character;

  const SpringSkinButton({
    super.key,
    required this.character,
  });

  @override
  State<StatefulWidget> createState() {
    return _SpringSkinButtonState();
  }
}

class _SpringSkinButtonState extends State<SpringSkinButton> {
  @override
  Widget build(BuildContext context) {
    return ImageButton(
      icon: const Icon(Icons.spa_outlined),
      onPressed: () {
        widget.character.switchSpringMode();
        Navigator.pushReplacementNamed(
          context,
          Routes.destinyChildCharacterDetail,
          arguments: widget.character,
        );
      },
      tooltip: S.of(context).tooltipSpringSkin,
    );
  }
}
