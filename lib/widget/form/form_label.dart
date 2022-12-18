import 'package:flutter/material.dart';

class FormLabel extends StatelessWidget {
  final String label;
  const FormLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.only(left: 10),
      child: Text(
        label,
        textAlign: TextAlign.left,
      ),
    );
  }
}
