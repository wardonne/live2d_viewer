import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget {
  final double? height;
  final Color? color;
  final Widget? title;
  final List<Widget>? leadingActions;
  final List<Widget>? endActions;
  final BoxDecoration? decoration;

  const Toolbar({
    super.key,
    this.height = 48,
    this.color,
    this.title,
    this.leadingActions,
    this.endActions,
    this.decoration,
  });

  Toolbar.header({
    super.key,
    this.height = 48,
    this.title,
    this.leadingActions,
    this.endActions,
    Color color = Colors.transparent,
    Color borderColor = Colors.white70,
    double borderWidth = 1,
  })  : color = null,
        decoration = BoxDecoration(
          color: color,
          border: Border(
            bottom: BorderSide(
              color: borderColor,
            ),
          ),
        );

  Toolbar.footer({
    super.key,
    this.height = 48,
    this.title,
    this.leadingActions,
    this.endActions,
    Color color = Colors.transparent,
    Color borderColor = Colors.white70,
    double borderWidth = 1,
  })  : color = null,
        decoration = BoxDecoration(
          color: color,
          border: Border(
            top: BorderSide(
              color: borderColor,
            ),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      color: color,
      decoration: decoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonPadding: const EdgeInsets.only(left: 30),
            children: leadingActions ?? [],
          ),
          Expanded(
            child: Container(
              child: title,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonPadding: const EdgeInsets.only(right: 30),
            children: endActions ?? [],
          ),
        ],
      ),
    );
  }
}
