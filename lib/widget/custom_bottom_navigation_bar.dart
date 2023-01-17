import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final Color? color;
  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    this.height = 50,
    this.color,
  });

  @override
  State<StatefulWidget> createState() {
    return CustomBottomNavigationBarState();
  }
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.color,
      ),
      child: Row(
        children: widget.items.map((item) => Expanded(child: item)).toList(),
      ),
    );
  }
}
