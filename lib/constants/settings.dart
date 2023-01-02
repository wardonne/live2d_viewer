import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

const appName = 'Live2D Viewer';
const initSize = Size(1440, 768);
const minSize = initSize;

const defaultWindowOptions = WindowOptions(
    title: appName,
    size: initSize,
    center: true,
    minimumSize: minSize,
    titleBarStyle: TitleBarStyle.normal);

const defaultActionIconButtonSplashRadius = 20.0;

const defaultAppBarShape =
    Border(bottom: BorderSide(color: Colors.black, width: 1));

const dcName = 'Destiny Child';
const nikkiName = 'Nikki';
const settingName = 'Settings';

const double headerBarHeight = 48;
const double footerBarHeight = 49;

const Color barColor = Colors.black26;
