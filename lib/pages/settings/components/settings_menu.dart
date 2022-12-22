import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/settings.dart';
import 'package:live2d_viewer/widget/toolbar.dart';

class SettingsMenu extends StatelessWidget {
  final List<SettingMenuItem> items;
  const SettingsMenu({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: Colors.white70)),
      ),
      child: Column(
        children: [
          Toolbar.header(
            height: headerBarHeight,
          ),
          Expanded(
            child: Container(
              color: barColor,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return items[index].build(context);
                },
              ),
            ),
          ),
          Toolbar.footer(
            height: footerBarHeight,
          ),
        ],
      ),
    );
  }
}

class SettingMenuItem extends StatelessWidget {
  final GlobalKey anchorKey;
  final String label;
  final List<SettingMenuItem>? children;

  const SettingMenuItem({
    super.key,
    required this.anchorKey,
    required this.label,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return children == null || children!.isEmpty
        ? ListTile(
            title: Text(label),
            selectedTileColor: Colors.black,
            onTap: () {
              Scrollable.ensureVisible(
                  anchorKey.currentContext as BuildContext);
            },
          )
        : ExpansionTile(
            title: Text(label),
            children: children!.map((child) {
              return child.build(context);
            }).toList(),
            onExpansionChanged: (value) {
              Scrollable.ensureVisible(
                  anchorKey.currentContext as BuildContext);
            },
          );
  }
}
