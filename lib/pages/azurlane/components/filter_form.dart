import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/enum/ship_nationality.dart';
import 'package:live2d_viewer/enum/ship_type.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';

class FilterForm extends StatefulWidget {
  final FilterFormModel model;

  const FilterForm({
    super.key,
    required this.model,
  });

  @override
  State<StatefulWidget> createState() {
    return FilterFormState();
  }
}

class FilterFormState extends State<FilterForm> {
  late final FilterFormModel model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Dialog(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            color: Styles.popupBackgrounColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Styles.borderColor)),
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.filter_list_alt),
                    const VerticalDivider(
                      width: 5.0,
                      color: Colors.transparent,
                    ),
                    Text(S.of(context).filterTitle),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: S.of(context).formLabelName,
                        ),
                        initialValue: model.name,
                        onSaved: (value) => model.name = value,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: S.of(context).formLabelRarity,
                        ),
                        dropdownMaxHeight: 300,
                        items: AzurlaneConstants.rarityLabels.keys
                            .map((rarity) => DropdownMenuItem<int>(
                                  value: rarity,
                                  child: Text(
                                      AzurlaneConstants.rarityLabels[rarity]!),
                                ))
                            .toList(),
                        value: model.rarity,
                        onChanged: (value) {},
                        onSaved: (value) => model.rarity = value,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: S.of(context).formLabelType,
                        ),
                        dropdownMaxHeight: 300,
                        items: ShipType.values
                            .map((item) => DropdownMenuItem<int>(
                                  value: item.value,
                                  child: Text(item.label),
                                ))
                            .toList(),
                        value: model.type,
                        onChanged: (value) {},
                        onSaved: (value) => model.type = value,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: S.of(context).formLabelNationality,
                        ),
                        dropdownMaxHeight: 300,
                        items: ShipNationality.values
                            .map((item) => DropdownMenuItem<int>(
                                  value: item.value,
                                  child: Text(item.label),
                                ))
                            .toList(),
                        value: model.nationality,
                        onChanged: (value) {},
                        onSaved: (value) => model.nationality = value,
                      ),
                      const SizedBox(height: 10),
                      ButtonBar(
                        children: [
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ElevatedButton.icon(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Styles.warningButtonColor)),
                              icon: const Icon(Icons.replay_outlined),
                              onPressed: () {
                                (formKey.currentState as FormState).reset();
                                (formKey.currentState as FormState).save();
                                Navigator.pop(context, model);
                              },
                              label: Text(S.of(context).buttonReset),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                (formKey.currentState as FormState).save();
                                Navigator.pop(context, model);
                              },
                              label: Text(S.of(context).buttonSubmit),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
