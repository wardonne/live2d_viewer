import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/pages/destiny_child/components/character_view.dart';
import 'package:live2d_viewer/pages/destiny_child/components/item_list.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/destiny_child/soul_carta_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';

class DestinyChildPage extends StatefulWidget {
  const DestinyChildPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return DestinyChildPageState();
  }
}

class DestinyChildPageState extends State<DestinyChildPage>
    with SingleTickerProviderStateMixin {
  final soulCartaEditModeController =
      DestinyChildConstants.soulCartaEditModeController;
  final CharacterViewController childViewController = CharacterViewController();
  late TabController tabController;
  late SoulCartaService? soulCartaService;
  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: DestinyChildConstants.tabbars.length, vsync: this)
          ..addListener(() {
            if (tabController.indexIsChanging) {
              DestinyChildConstants.activeTabIndex = tabController.index;
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    var destinyChildSettings = watchProvider<SettingsProvider>(context)
        .settings!
        .destinyChildSettings!;
    soulCartaService = SoulCartaService(destinyChildSettings);
    tabController.animateTo(DestinyChildConstants.activeTabIndex ??
        destinyChildSettings.defaultHome ??
        DestinyChildConstants.defaultHome);
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) {
        return AnimatedBuilder(
          animation: DestinyChildConstants.itemListController,
          builder: (context, child) {
            return Row(
              children: [
                if (DestinyChildConstants.itemListController.visible)
                  Expanded(
                    child: ItemList(
                      tabController: tabController,
                    ),
                  ),
                if (!DestinyChildConstants.itemListController.visible)
                  Expanded(
                    child: _getDetailWidgetByIndex(tabController.index),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _getDetailWidgetByIndex(int index) {
    return DestinyChildConstants.detailWindows[index];
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
