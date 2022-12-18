import 'package:flutter/material.dart';

class FormTextInput extends StatelessWidget {
  final String? value;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const FormTextInput({
    super.key,
    this.value,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      onSaved: onSaved,
      decoration: const InputDecoration(
        border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
