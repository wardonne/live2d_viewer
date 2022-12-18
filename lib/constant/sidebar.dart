import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/sidebar_item.dart';
import 'package:live2d_viewer/pages/destiny_child/index.dart';
import 'package:live2d_viewer/pages/settings/setting.dart';

import 'settings.dart';

final sidebarItems = <SidebarItem>[
  SidebarItem(
    title: dcName,
    iconData: Icons.child_friendly_outlined,
    builder: (context) => const DestinyChildPage(),
  ),
  SidebarItem(
    title: settingName,
    iconData: Icons.settings,
    builder: (context) => SettingPage(),
  ),
];
