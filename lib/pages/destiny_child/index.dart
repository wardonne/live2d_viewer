import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/widget/widget.dart';

class DestinyChildPage extends StatefulWidget {
  const DestinyChildPage({super.key});
  @override
  State<StatefulWidget> createState() => DestinyChildPageState();
}

class DestinyChildPageState extends State<DestinyChildPage> {
  int _activeTabIndex = 0;

  final List<Widget> _pages = [
    const Center(
      child: Text('0'),
    ),
    const Center(
      child: Text('1'),
    )
  ];

  _switchTab(int index) {
    _activeTabIndex = index;
    debugPrint(_activeTabIndex.toString());
    setState(() {});
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
            hoverBackgroundColor: Styles.hoverBackgroundColor,
            onClick: () {
              _switchTab(0);
            },
            child: Center(child: Text(S.of(context).soulCarta)),
          ),
          ContainerButton(
            hoverBackgroundColor: Styles.hoverBackgroundColor,
            child: Center(child: Text(S.of(context).soulCarta)),
            onClick: () {
              _switchTab(1);
            },
          ),
        ],
      ),
      body: _pages[_activeTabIndex],
    );
  }
}
