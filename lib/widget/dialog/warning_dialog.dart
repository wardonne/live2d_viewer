import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/dialog/base_dialog.dart';

class WarningDialog extends BaseDialog {
  WarningDialog({
    super.key,
    super.message,
  }) : super(
          icon: const Icon(Icons.warning),
          iconColor: Colors.amber[900],
          title: 'Warning',
        );
}
