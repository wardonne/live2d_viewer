import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/girl_frontline/models.dart';

class FilterFormNameInput extends StatefulWidget {
  final FilterFormModel model;
  const FilterFormNameInput({
    super.key,
    required this.model,
  });

  @override
  State<StatefulWidget> createState() {
    return FilterFormNameInputState();
  }
}

class FilterFormNameInputState extends State<FilterFormNameInput> {
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
                S.of(context).formLabelName,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          Flexible(
              child: TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.zero),
            ),
            initialValue: model.name,
            onSaved: (value) => model.name = value.toString(),
          )),
        ],
      ),
    );
  }
}
