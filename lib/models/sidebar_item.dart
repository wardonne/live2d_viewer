import 'package:flutter/material.dart';

class SidebarItem extends Object {
  final String title;
  final IconData iconData;
  final WidgetBuilder builder;

  SidebarItem({
    required this.title,
    required this.iconData,
    required this.builder,
  });
}
