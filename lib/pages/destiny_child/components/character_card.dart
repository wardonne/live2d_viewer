import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/destiny_child/character.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';

import 'character_avatar.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final Skin? skin;
  final bool _isSkin;
  const CharacterCard({
    super.key,
    required this.character,
    this.skin,
  }) : _isSkin = skin != null;

  void _toDetail(BuildContext context) {
    if (_isSkin) {
      character.activeSkinIndex = character.skins.indexOf(skin!);
      Navigator.pushReplacementNamed(
        context,
        Routes.destinyChildCharacterDetail,
        arguments: character,
      );
    } else {
      Navigator.pushNamed(
        context,
        Routes.destinyChildCharacterDetail,
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
          ),
          const Divider(
            height: 2,
            color: Colors.transparent,
          ),
          Center(
            child: Text(_isSkin ? skin!.name.split('_')[0] : character.name),
          ),
        ],
      ),
    );
  }
}