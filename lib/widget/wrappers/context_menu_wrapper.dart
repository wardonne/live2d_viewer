import 'package:contextmenu/contextmenu.dart';
import 'package:flutter/material.dart';

class ContextMenuWrapper extends StatelessWidget {
  final Widget child;
  final List<Widget> Function(BuildContext) itemBuilder;
  final double? width;
  const ContextMenuWrapper({
    super.key,
    required this.child,
    required this.itemBuilder,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ContextMenuArea(
      builder: itemBuilder,
      width: width ?? 200,
      verticalPadding: 0.0,
      child: child,
    );
  }
}
