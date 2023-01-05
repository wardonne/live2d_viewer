import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/constants/nikke.dart';
import 'package:live2d_viewer/models/sidebar_item.dart';
import 'package:live2d_viewer/pages/destiny_child/index.dart';
import 'package:live2d_viewer/pages/nikke/index.dart';
import 'package:live2d_viewer/pages/settings/index.dart';

import 'application.dart';

final sidebarItems = <SidebarItem>[
  SidebarItem(
    title: DestinyChildConstants.menuName,
    iconData: Icons.child_friendly_outlined,
    builder: (context) => const DestinyChildPage(),
  ),
  SidebarItem(
    title: NikkeConstants.menuName,
    iconData: Icons.donut_large_rounded,
    builder: (context) => const NikkePage(),
  ),
  SidebarItem(
    title: settingName,
    iconData: Icons.settings,
    builder: (context) => SettingPage(),
  ),
];
