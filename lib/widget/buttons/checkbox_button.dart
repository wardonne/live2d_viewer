import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/constants/constants.dart';

class CheckboxButton<T> extends StatefulWidget {
  final bool selected;
  final Widget? label;
  final String? labelText;
  final T value;
  final void Function(T value, bool selected) onTap;
  const CheckboxButton({
    super.key,
    required this.selected,
    this.label,
    this.labelText,
    required this.value,
    required this.onTap,
  }) : assert(!(label == null && labelText == null),
            'label and labelText can\'t both be null');

  @override
  State<StatefulWidget> createState() {
    return CheckboxButtonState<T>();
  }
}

class CheckboxButtonState<T> extends State<CheckboxButton<T>> {
  late bool selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Container(
          width: 120,
          height: 55,
          constraints: const BoxConstraints(minWidth: 120),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: Styles.hoverBackgroundColor,
            border: Border.all(
              color: selected ? Styles.selectedBorderColor : Styles.borderColor,
            ),
          ),
          child: Center(
            child: widget.label ??
                Text(widget.labelText!, style: const TextStyle(fontSize: 16.0)),
          ),
        ),
        onTap: () {
          setState(() {
            selected = !selected;
            widget.onTap(widget.value, selected);
          });
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CheckboxButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      selected = widget.selected;
    });
  }
}
