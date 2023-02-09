import 'package:flutter/material.dart';
import 'package:live2d_viewer/pages/girl_frontline/character_list.dart';

class GirlFrontlinePage extends StatefulWidget {
  const GirlFrontlinePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return GirlFrontlinePageState();
  }
}

class GirlFrontlinePageState extends State<GirlFrontlinePage> {
  @override
  Widget build(BuildContext context) {
    return const CharacterList();
  }
}
