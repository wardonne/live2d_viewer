import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/language_selection.dart';
import 'package:live2d_viewer/constants/controllers.dart';
import 'package:live2d_viewer/constants/games.dart';
import 'package:live2d_viewer/constants/sidebar.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';
import 'package:sidebarx/sidebarx.dart';

class IndexPage extends StatelessWidget {
  final SidebarXController _controller = sideBarController;

  final List<SidebarXItem> _items = [];

  IndexPage({super.key}) {
    for (final sidebarItem in sidebarItems) {
      _items.add(SidebarXItem(
        icon: sidebarItem.iconData,
        label: sidebarItem.title,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const LanguageSelection(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: (MediaQuery.of(context).size.width - 600) / 2,
            top: (MediaQuery.of(context).size.height - 400) / 2 - 50,
            child: Container(
              height: 400,
              width: 600,
              decoration: BoxDecoration(
                color: Styles.popupBackgrounColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.white70),
              ),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white70),
                      ),
                    ),
                    child: Center(child: Text(S.of(context).indexTitle)),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Wrap(
                        spacing: 10,
                        children: Games.list
                            .map((item) => ContainerButton(
                                  width: 80,
                                  padding: const EdgeInsets.all(10),
                                  hoverBackgroundColor:
                                      Styles.hoverBackgroundColor,
                                  onClick: () =>
                                      Navigator.pushNamed(context, item.route),
                                  child: Column(
                                    children: [
                                      Center(child: Image.asset(item.icon)),
                                      const Divider(
                                          height: 5, color: Colors.transparent),
                                      Center(
                                        child: Text(
                                          S.of(context).gameTitles(item.name),
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.textStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final settings = watchProvider<SettingsProvider>(context).settings!;
  //   sideBarController.selectIndex(int.tryParse(
  //           settings.applicationSettings?.defaultSidebar ??
  //               ApplicationConstants.defaultSidebar) ??
  //       0);
  //   var sidebar = _buildSideBar();
  //   var content = _buildContent(context);
  //   return Scaffold(
  //     body: Row(
  //       children: [
  //         sidebar,
  //         Expanded(
  //           child: Center(
  //             child: content,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // SideBar _buildSideBar() {
  //   return SideBar(
  //     controller: _controller,
  //     avatarImage: Image.asset(ResourceConstants.appIcon),
  //     items: _items,
  //   );
  // }

  // Widget _buildContent(BuildContext context) {
  //   return AnimatedBuilder(
  //     animation: _controller,
  //     builder: (context, child) {
  //       final selectedIndex = _controller.selectedIndex;
  //       final widgetBuilder = sidebarItems[selectedIndex].builder;
  //       return widgetBuilder(context);
  //     },
  //   );
  // }
}
