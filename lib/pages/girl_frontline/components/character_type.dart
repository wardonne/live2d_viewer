import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/models/girl_frontline/character_model.dart';

class CharacterType extends StatelessWidget {
  final CharacterModel character;
  const CharacterType({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 38,
      child: Image.asset(character.gunType.icons[character.rank]!),
    );
  }
}
