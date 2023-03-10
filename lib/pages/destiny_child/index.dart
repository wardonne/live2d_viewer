import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/pages/destiny_child/soul_carta_list.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/widget.dart';
import 'package:live2d_viewer/pages/destiny_child/character_list.dart';

class DestinyChildPage extends StatefulWidget {
  const DestinyChildPage({super.key});
  @override
  State<StatefulWidget> createState() => DestinyChildPageState();
}

class DestinyChildPageState extends State<DestinyChildPage> {
  int _activeIndex = 0;
  final _characterListStateKey = GlobalKey<CharacterListState>();
  final _soulCartaListStateKey = GlobalKey<SoulCartaListState>();
  late final List<Widget> _pages;
  late final List<GlobalKey<RefreshableState<StatefulWidget>>> _keys;

  @override
  initState() {
    _keys = [
      _characterListStateKey,
      _soulCartaListStateKey,
    ];
    _pages = [
      CharacterList(key: _characterListStateKey),
      SoulCartaList(key: _soulCartaListStateKey),
    ];
    super.initState();
    hotKeyManager.register(
      HotKeys.find,
      keyDownHandler: (hotKey) {
        if (ModalRoute.of(context)!.isCurrent) {
          final activeKey = _keys[_activeIndex];
          if (_activeIndex == 0) {
            (activeKey as GlobalKey<CharacterListState>)
                .currentState!
                .showFilter();
          }
        }
      },
    );
  }

  @override
  dispose() {
    hotKeyManager.unregister(HotKeys.find);
    super.dispose();
  }

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
            margin: const EdgeInsets.only(right: 10),
            child: ImageButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () => '',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ToolbarRefreshButton(widgetKey: _keys[_activeIndex]),
          ),
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
