import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/form/form_label.dart';

class FormFieldWithLabel extends StatelessWidget {
  final String label;
  final Widget field;

  const FormFieldWithLabel({
    super.key,
    required this.label,
    required this.field,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 0,
              child: FormLabel(label: label),
            ),
            Expanded(
              child: field,
            ),
          ],
        ),
      ),
    );
  }
}
