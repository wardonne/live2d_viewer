import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';

class FilterFormRaritySelection extends StatefulWidget {
  final FilterFormModel model;

  const FilterFormRaritySelection({
    super.key,
    required this.model,
  });

  @override
  State<StatefulWidget> createState() {
    return FilterFormRaritySelectionState();
  }
}

class FilterFormRaritySelectionState extends State<FilterFormRaritySelection> {
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
                S.of(context).formLabelRarity,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: Wrap(
                runSpacing: 4.0,
                children: AzurlaneConstants.rarityLabels.keys.map((rarity) {
                  return CheckboxButton<int>(
                    selected: model.rarity.contains(rarity),
                    labelText: AzurlaneConstants.rarityLabels[rarity]!,
                    value: rarity,
                    onTap: (value, selected) {
                      if (selected) {
                        model.rarity.add(rarity);
                      } else {
                        model.rarity.remove(rarity);
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
