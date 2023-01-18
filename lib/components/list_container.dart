import 'package:flutter/material.dart';

class ListContainer extends StatelessWidget {
  final List<Widget> items;
  const ListContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: items,
        ),
      ),
    );
  }
}
