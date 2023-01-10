import 'package:flutter/material.dart';

class ContainerButton extends StatefulWidget {
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? color;
  final Color? hoverColor;
  final void Function()? onClick;
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const ContainerButton({
    super.key,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.color,
    this.hoverColor,
    this.onClick,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
  });

  @override
  State<ContainerButton> createState() => _ContainerButtonState();
}

class _ContainerButtonState extends State<ContainerButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: isHover ? widget.hoverColor : widget.color),
      child: Container(
        width: widget.width,
        height: widget.height,
        color: isHover ? widget.hoverBackgroundColor : widget.backgroundColor,
        padding: widget.padding,
        margin: widget.margin,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          child: GestureDetector(
            onTap: widget.onClick,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
