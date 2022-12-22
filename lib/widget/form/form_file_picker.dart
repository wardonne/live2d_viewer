import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/widget/buttons/file_picker_button.dart';

class FormFilePicker extends StatelessWidget {
  final TextEditingController controller;
  final String? value;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;

  const FormFilePicker({
    super.key,
    required this.controller,
    this.value,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      controller.value = TextEditingValue(text: value!);
    }
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              readOnly: true,
              onChanged: onChanged,
              onSaved: onSaved,
              validator: validator,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10, start: 10),
                  child: FilePickerIconButton(
                    icon: const Icon(Icons.file_upload),
                    pickDirectory: true,
                    initialDirectory: Directory.current.path,
                    onDirectirySelected: (value) {
                      if (value != null) {
                        controller.value = TextEditingValue(text: value);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
