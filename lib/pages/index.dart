import 'package:flutter/material.dart';
import 'package:live2d_viewer/constant/controllers.dart';
import 'package:live2d_viewer/constant/resources.dart';
import 'package:live2d_viewer/constant/sidebar.dart';
import 'package:live2d_viewer/widget/sidebar.dart';
import 'package:sidebarx/sidebarx.dart';

var activeTabIndex = 0;

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
    var sidebar = _buildSideBar();
    var content = _buildContent(context);
    return Scaffold(
      body: Row(
        children: [
          sidebar,
          Expanded(
            child: Center(
              child: content,
            ),
          ),
        ],
      ),
    );
  }

  SideBar _buildSideBar() {
    return SideBar(
      controller: _controller,
      avatarImage: Image.asset(appIcon),
      items: _items,
    );
  }

  Widget _buildContent(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final selectedIndex = _controller.selectedIndex;
        final widgetBuilder = sidebarItems[selectedIndex].builder;
        return widgetBuilder(context);
      },
    );
  }
}
