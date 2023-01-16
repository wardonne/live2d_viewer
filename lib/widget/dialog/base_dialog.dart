import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  final Widget? icon;
  final Color? iconColor;
  final String? title;
  final String? message;
  final List<Widget>? actions;
  const BaseDialog({
    super.key,
    this.icon,
    this.iconColor,
    this.title,
    this.message,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon,
      iconColor: iconColor,
      title: title != null ? Text(title!, textScaleFactor: 1.5) : null,
      content: message != null
          ? SizedBox(
              height: 150,
              width: 400,
              child: SingleChildScrollView(child: Text(message!)),
            )
          : null,
      actions: actions == null || actions!.isEmpty
          ? [
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ]
          : actions,
    );
  }
}
