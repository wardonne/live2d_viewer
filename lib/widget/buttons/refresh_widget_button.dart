// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';

class RefreshWidgetButton extends StatelessWidget {
  final GlobalKey? widgetKey;
  final Widget child;
  final String? title;
  final dynamic Function()? beforeRefresh;
  final dynamic Function()? refreshFunction;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? color;
  final Color? hoverColor;

  const RefreshWidgetButton({
    super.key,
    this.widgetKey,
    required this.child,
    this.title,
    this.beforeRefresh,
    this.refreshFunction,
    this.width,
    this.height,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.color,
    this.hoverColor,
  }) : assert(
            widgetKey != null || (widgetKey == null && refreshFunction != null),
            'widgetKey and refreshFunction can\'t be both empty');

  @override
  Widget build(BuildContext context) {
    return ContainerButton(
      width: width,
      height: height,
      backgroundColor: backgroundColor,
      hoverBackgroundColor: hoverBackgroundColor,
      color: color,
      hoverColor: hoverColor,
      child: Row(
        children: [
          child,
          if (title != null) Expanded(child: Text(title!)),
        ],
      ),
      onClick: () async {
        if (beforeRefresh != null) {
          await beforeRefresh!();
        }
        if (refreshFunction != null) {
          await refreshFunction!();
        } else {
          widgetKey!.currentState?.setState(() {});
        }
      },
    );
  }
}
