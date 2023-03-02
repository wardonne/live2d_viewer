import 'package:flutter/material.dart';

class FormResetButton extends StatefulWidget {
  final Widget icon;
  final Widget? label;
  final String? labelText;
  final double? height;
  final double? minWidth;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final void Function()? beforeReset;
  final void Function()? afterReset;
  final GlobalKey<FormState> formKey;

  const FormResetButton({
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
    this.beforeReset,
    this.afterReset,
  }) : assert(!(label == null && labelText == null),
            'label and labelText can\'t be both empty');

  @override
  State<StatefulWidget> createState() {
    return FormResetButtonState();
  }
}

class FormResetButtonState extends State<FormResetButton> {
  click() {
    if (widget.beforeReset != null) widget.beforeReset!();
    (widget.formKey.currentState as FormState).reset();
    if (widget.afterReset != null) widget.afterReset!();
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
