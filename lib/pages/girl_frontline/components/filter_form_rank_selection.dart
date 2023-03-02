import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/enum/gun_rank.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/girl_frontline/models.dart';
import 'package:live2d_viewer/pages/girl_frontline/components/character_star.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';

class FilterFormRankSelection extends StatefulWidget {
  final FilterFormModel model;
  const FilterFormRankSelection({
    super.key,
    required this.model,
  });

  @override
  State<StatefulWidget> createState() {
    return FilterFormRankSelectionState();
  }
}

class FilterFormRankSelectionState extends State<FilterFormRankSelection> {
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
              style: const TextStyle(fontSize: 16.0),
            )),
          ),
          Flexible(
            child: Container(
              margin: const EdgeInsets.only(left: 16.0),
              child: Wrap(
                runSpacing: 4.0,
                children: GunRank.values.map((rank) {
                  return CheckboxButton(
                    selected: model.rank.contains(rank.value),
                    label: CharacterStar(rank: rank.value),
                    value: rank.value,
                    onTap: (value, selected) {
                      if (selected) {
                        model.rank.add(value);
                      } else {
                        model.rank.remove(value);
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
