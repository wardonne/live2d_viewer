import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/buttons/close_window_button.dart';
import 'package:live2d_viewer/widget/buttons/maximize_window_button.dart';
import 'package:live2d_viewer/widget/buttons/minimize_window_button.dart';
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

const defaultAppbarActions = <Widget>[
  MinimizeWindowButton(),
  MaximizeWindowButton(),
  CloseWindowButton(),
];

const defaultAppBarShape =
    Border(bottom: BorderSide(color: Colors.black, width: 1));

const dcName = 'Destiny Child';
const settingName = 'Settings';
const diviceName = 'USB Divices';
