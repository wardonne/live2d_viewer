import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/models/destiny_child/character.dart';

class CharacterDetail extends StatelessWidget {
  const CharacterDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as Character;
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: LanguageSelection(),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
