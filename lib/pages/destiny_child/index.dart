import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/pages/destiny_child/soul_carta_list.dart';
import 'package:live2d_viewer/widget/widget.dart';

import 'character_list.dart';

class DestinyChildPage extends StatefulWidget {
  const DestinyChildPage({super.key});
  @override
  State<StatefulWidget> createState() => DestinyChildPageState();
}

class DestinyChildPageState extends State<DestinyChildPage> {
  int _activeIndex = 0;

  final List<Widget> _pages = [
    const CharacterList(),
    const SoulCartaList(),
  ];

  _changeTo(int index) {
    setState(() {
      _activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).destinyChild),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const LanguageSelection(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        height: Styles.bottomAppBarHeight,
        color: Styles.appBarColor,
        items: [
          ContainerButton(
            backgroundColor:
                _activeIndex == 0 ? Styles.hoverBackgroundColor : null,
            hoverBackgroundColor: Styles.hoverBackgroundColor,
            onClick: () => _changeTo(0),
            child: Center(child: Text(S.of(context).child)),
          ),
          ContainerButton(
            backgroundColor:
                _activeIndex == 1 ? Styles.hoverBackgroundColor : null,
            hoverBackgroundColor: Styles.hoverBackgroundColor,
            child: Center(child: Text(S.of(context).soulCarta)),
            onClick: () => _changeTo(1),
          ),
        ],
      ),
      body: _pages[_activeIndex],
    );
  }
}
