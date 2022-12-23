import 'package:flutter/material.dart';

class EditableCellInput extends StatelessWidget {
  final EditableCellInputController controller;
  final TextEditingController? textEditingController;
  final String? initialValue;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  const EditableCellInput({
    super.key,
    required this.controller,
    this.textEditingController,
    this.initialValue,
    this.focusNode,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return TextFormField(
          controller: textEditingController,
          initialValue: initialValue,
          readOnly: controller.readOnly,
          focusNode: focusNode,
          textAlign: textAlign,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        );
      },
    );
  }
}

class EditableCellInputController extends ChangeNotifier {
  bool readOnly;
  EditableCellInputController({this.readOnly = false});

  setReadOnly(bool readOnly) {
    if (this.readOnly != readOnly) {
      this.readOnly = readOnly;
      notifyListeners();
    }
  }
}
