import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class FormDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final void Function(T?)? onChanged;
  final void Function(T?)? onSaved;
  final String? Function(T?)? validator;

  const FormDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      items: items,
      value: value,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      buttonHeight: 52,
      buttonPadding: const EdgeInsets.only(left: 10, right: 10),
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
      ),
      focusColor: Colors.transparent,
      buttonSplashColor: Colors.transparent,
    );
  }
}
