import 'package:flutter/material.dart';

class FormSubmitButton extends StatefulWidget {
  final Widget icon;
  final Widget? label;
  final String? labelText;
  final double? height;
  final double? minWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final void Function()? beforeSubmit;
  final void Function()? afterSubmit;
  final GlobalKey<FormState> formKey;

  const FormSubmitButton({
    super.key,
    required this.formKey,
    required this.icon,
    this.label,
    this.labelText,
    this.height,
    this.minWidth,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.beforeSubmit,
    this.afterSubmit,
  }) : assert(!(label == null && labelText == null),
            'label and labelText can\'t be both empty');

  @override
  State<StatefulWidget> createState() {
    return FormSubmitButtonState();
  }
}

class FormSubmitButtonState extends State<FormSubmitButton> {
  click() {
    if (widget.beforeSubmit != null) widget.beforeSubmit!();
    (widget.formKey.currentState as FormState).save();
    if (widget.afterSubmit != null) widget.afterSubmit!();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: widget.padding,
      margin: widget.margin,
      constraints: BoxConstraints(minWidth: widget.minWidth ?? 0.0),
      child: ElevatedButton.icon(
        onPressed: click,
        icon: widget.icon,
        label: widget.label ?? Text(widget.labelText!),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(widget.backgroundColor),
        ),
      ),
    );
  }
}
