import 'package:flutter/material.dart';
import 'package:live2d_viewer/constant/settings.dart';
import 'package:live2d_viewer/widget/preview_windows/preview_window.dart';
import 'package:live2d_viewer/widget/wrappers/colored_tabbar_wrapper.dart';
import 'components/child.dart';
import 'components/soul_carta.dart';

class DestinyChildPage extends StatefulWidget {
  const DestinyChildPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return DestinyChildPageState();
  }
}

class DestinyChildPageState extends State<DestinyChildPage>
    with SingleTickerProviderStateMixin {
  final PreviewWindowController controller = PreviewWindowController();
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (tabController.indexIsChanging && controller.visible) {
          controller.hidden();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, child) {
        return Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  ColoredTabBarWrapper(
                    tabBar: TabBar(
                      indicator: const BoxDecoration(
                        color: Colors.black54,
                      ),
                      controller: tabController,
                      tabs: const [
                        Tab(text: 'Child'),
                        Tab(text: 'Soul Carta'),
                      ],
                    ),
                    color: barColor,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        ChildTabView(
                          controller: controller,
                        ),
                        SoulCartaTabView(
                          controller: controller,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PreviewWindow(controller: controller)
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
