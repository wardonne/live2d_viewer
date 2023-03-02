import 'package:flutter/material.dart';

class CheckboxDropdownMenuItemWrapper<T> extends StatefulWidget {
  final T value;
  final String label;
  final bool selected;
  final void Function(T value, bool selected)? onChange;
  const CheckboxDropdownMenuItemWrapper({
    super.key,
    required this.value,
    required this.label,
    required this.selected,
    this.onChange,
  });

  @override
  State<StatefulWidget> createState() {
    return CheckboxDropdownMenuItemWrapperState<T>();
  }
}

class CheckboxDropdownMenuItemWrapperState<T>
    extends State<CheckboxDropdownMenuItemWrapper<T>> {
  late bool selected;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onChange != null) {
          widget.onChange!(widget.value, !selected);
        }
        setState(() {
          selected = !selected;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            selected
                ? const Icon(Icons.check_box_outlined)
                : const Icon(Icons.check_box_outline_blank),
            const VerticalDivider(width: 16.0, color: Colors.transparent),
            Text(widget.label),
          ],
        ),
      ),
    );
  }
}
