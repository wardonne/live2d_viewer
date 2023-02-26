import 'package:flutter/material.dart';

class ListContainer extends StatelessWidget {
  final List<Widget> items;
  final double width;
  final double height;
  const ListContainer({
    super.key,
    required this.items,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: GridView.extent(
        maxCrossAxisExtent: width,
        childAspectRatio: width / height,
        children: items,
      ),
    );
  }
}
