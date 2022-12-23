import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/pages/destiny_child/components/child_view.dart';
import 'package:live2d_viewer/pages/destiny_child/components/items.dart';
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
      DestinyChildConstant.soulCartaEditModeController;
  final ChildViewController childViewController = ChildViewController();
  late TabController tabController;
  late SoulCartaService? soulCartaService;
  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: DestinyChildConstant.tabbars.length, vsync: this)
          ..addListener(() {
            if (tabController.indexIsChanging) {
              DestinyChildConstant.activeTabIndex = tabController.index;
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    var destinyChildSettings = watchProvider<SettingsProvider>(context)
        .settings!
        .destinyChildSettings!;
    soulCartaService = SoulCartaService(destinyChildSettings);
    tabController.animateTo(DestinyChildConstant.activeTabIndex ??
        destinyChildSettings.defaultHome ??
        DestinyChildConstant.defaultHome);
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) {
        return AnimatedBuilder(
          animation: DestinyChildConstant.itemListController,
          builder: (context, child) {
            return Row(
              children: [
                if (DestinyChildConstant.itemListController.visible)
                  Expanded(
                    child: ItemList(
                      tabController: tabController,
                    ),
                  ),
                if (!DestinyChildConstant.itemListController.visible)
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
    return DestinyChildConstant.detailWindows[index];
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
