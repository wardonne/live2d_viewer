import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/enum/ship_nationality.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';

class FilterFormNationalitySelection extends StatefulWidget {
  final FilterFormModel model;
  const FilterFormNationalitySelection({
    super.key,
    required this.model,
  });

  @override
  State<StatefulWidget> createState() {
    return FilterFormNationalitySelectionState();
  }
}

class FilterFormNationalitySelectionState
    extends State<FilterFormNationalitySelection> {
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
                S.of(context).formLabelNationality,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: Wrap(
                runSpacing: 4.0,
                children: ShipNationality.values.map((nationality) {
                  return CheckboxButton(
                    selected: model.nationality.contains(nationality.value),
                    labelText: nationality.label,
                    value: nationality.value,
                    onTap: (value, selected) {
                      if (selected) {
                        model.nationality.add(nationality.value);
                      } else {
                        model.nationality.remove(nationality.value);
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
