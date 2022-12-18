import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/dialog/base_dialog.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      icon: const Icon(Icons.error),
      iconColor: Colors.red,
      title: 'error',
      message: message,
    );
  }
}
