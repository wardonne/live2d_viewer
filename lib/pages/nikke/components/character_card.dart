import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/routes.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/models/nikke/character_model.dart';
import 'package:live2d_viewer/models/nikke/skin_model.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';

import 'character_avatar.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;
  final SkinModel? skin;
  final bool _isSkin;
  const CharacterCard({
    super.key,
    required this.character,
    this.skin,
  }) : _isSkin = skin != null;

  void _toDetail(BuildContext context) {
    if (_isSkin) {
      if (character.activeSkin == skin) return;
      character.switchSkin(skin!);
      Navigator.pushReplacementNamed(
        context,
        Routes.nikkeCharacterDetail,
        arguments: character,
      );
    } else {
      Navigator.pushNamed(
        context,
        Routes.nikkeCharacterDetail,
        arguments: character,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ContainerButton(
      width: 100,
      padding: const EdgeInsets.all(10.0),
      backgroundColor: Colors.transparent,
      hoverBackgroundColor: Styles.hoverBackgroundColor,
      onClick: () => _toDetail(context),
      child: Column(
        children: [
          CharacterAvatar(
            avatar: _isSkin ? skin!.avatarURL : character.avatarURL,
            contextMenu: !_isSkin,
          ),
          const Divider(
            height: 2,
            color: Colors.transparent,
          ),
          Center(
            child: Text(character.name),
          ),
        ],
      ),
    );
  }
}
