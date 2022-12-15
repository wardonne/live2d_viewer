import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error),
      iconColor: Colors.red,
      title: const Text('error'),
      content: Center(
        child: Text(message),
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close')),
      ],
    );
  }
}
