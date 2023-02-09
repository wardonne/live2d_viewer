import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/girl_frontline/character_model.dart';

class CharacterName extends StatelessWidget {
  final CharacterModel character;
  final String name;
  const CharacterName({
    super.key,
    required this.name,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 170,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1, -170 / 15 + 1),
          end: Alignment.bottomRight,
          colors: [
            character.gunRank.color,
            character.gunRank.color,
            Colors.transparent,
          ],
          stops: const [0, 1 - 15 / 170, 1 - 15 / 170],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF404040),
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
