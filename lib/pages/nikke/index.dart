import 'package:flutter/material.dart';
import 'package:live2d_viewer/pages/nikke/character_list.dart';

class NikkePage extends StatefulWidget {
  const NikkePage({super.key});

  @override
  State<StatefulWidget> createState() => NikkePageState();
}

class NikkePageState extends State<NikkePage> {
  @override
  Widget build(BuildContext context) {
    return const CharacterList();
  }
}
