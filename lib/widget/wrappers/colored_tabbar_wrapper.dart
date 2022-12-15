import 'package:flutter/material.dart';

class ColoredTabBarWrapper extends Container implements PreferredSizeWidget {
  final TabBar tabBar;

  ColoredTabBarWrapper({super.key, super.color, required this.tabBar});

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: color,
          border: const Border(bottom: BorderSide(color: Colors.white70)),
        ),
        height: 48,
        child: tabBar,
      );
}
