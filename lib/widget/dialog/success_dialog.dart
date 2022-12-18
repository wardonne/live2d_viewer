import 'package:flutter/material.dart';

import 'base_dialog.dart';

class SuccessDialog extends StatelessWidget {
  final String message;
  const SuccessDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'success',
      message: message,
    );
  }
}
