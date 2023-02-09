import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/controllers/load_controller.dart';
import 'package:live2d_viewer/models/destiny_child/character_model.dart';
import 'package:live2d_viewer/models/destiny_child/skin_model.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'character_avatar.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;
  final SkinModel? skin;
  final bool _isSkin;
  CharacterCard({
    super.key,
    required this.character,
    this.skin,
  }) : _isSkin = skin != null;

  final loadController = LoadController();

  void _toDetail(BuildContext context) {
    if (_isSkin) {
      if (character.activeSkin == skin) return;
      character.switchSkin(skin!);
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
          VisibilityDetector(
            key: ObjectKey(_isSkin ? skin! : character),
            child: CharacterAvatar(
              avatar: _isSkin ? skin!.avatarURL : character.avatarURL,
              contextMenu: !_isSkin,
              controller: loadController,
            ),
            onVisibilityChanged: (info) => loadController.load = true,
          ),
          const Divider(
            height: 2,
            color: Colors.transparent,
          ),
          Center(
            child: Text(
              _isSkin ? skin!.name : character.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
