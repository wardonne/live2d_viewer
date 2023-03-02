import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/enum/ship_type.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';

class FilterFormTypeSelection extends StatefulWidget {
  final FilterFormModel model;
  const FilterFormTypeSelection({
    super.key,
    required this.model,
  });

  @override
  State<StatefulWidget> createState() {
    return FilterFormTypeSelectionState();
  }
}

class FilterFormTypeSelectionState extends State<FilterFormTypeSelection> {
  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Styles.hoverBackgroundColor,
              border: Border.all(color: Styles.borderColor),
            ),
            child: Center(
              child: Text(
                S.of(context).formLabelType,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: Wrap(
                runSpacing: 4.0,
                children: ShipType.values.map((type) {
                  return CheckboxButton<int>(
                    selected: model.type.contains(type.value),
                    labelText: type.label,
                    value: type.value,
                    onTap: (value, selected) {
                      if (selected) {
                        model.type.add(type.value);
                      } else {
                        model.type.remove(type.value);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
