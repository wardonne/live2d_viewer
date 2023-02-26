import 'package:flutter/material.dart';

class ListContainer extends StatelessWidget {
  final List<Widget> items;
  final double itemWidth;
  final double itemHeight;
  const ListContainer({
    super.key,
    required this.items,
    required this.itemWidth,
    required this.itemHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: GridView.extent(
        maxCrossAxisExtent: itemWidth,
        childAspectRatio: itemWidth / itemHeight,
        children: items,
      ),
    );
  }
}
