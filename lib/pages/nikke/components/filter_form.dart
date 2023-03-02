import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/wrappers/wrapper.dart';

class FilterForm extends StatefulWidget {
  final VisibleController visibleController;
  final ValueNotifyWrapper<String> filterController;
  const FilterForm({
    super.key,
    required this.visibleController,
    required this.filterController,
  });

  @override
  State<StatefulWidget> createState() {
    return FilterFormState();
  }
}

class FilterFormState extends State<FilterForm> {
  final formKey = GlobalKey<FormState>();
  final submitKey = GlobalKey<FormSubmitButtonState>();

  @override
  void initState() {
    super.initState();
    hotKeyManager.register(
      HotKeys.enter,
      keyDownHandler: (hotKey) {
        if (ModalRoute.of(context)!.isCurrent &&
            widget.visibleController.visible) {
          submitKey.currentState!.click();
        }
      },
    );
  }

  @override
  void dispose() {
    hotKeyManager.unregister(HotKeys.enter);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        decoration: const BoxDecoration(
          color: Styles.popupBackgrounColor,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        height: 55,
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero),
                          ),
                          initialValue: widget.filterController.value,
                          onSaved: (value) =>
                              widget.filterController.value = value.toString(),
                        ),
                      ),
                      Container(
                        width: 240,
                        padding: const EdgeInsets.all(8.0),
                        child: ButtonBar(
                          children: [
                            FormResetButton(
                              formKey: formKey,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              icon: const Icon(Icons.replay_outlined),
                              labelText: S.of(context).buttonReset,
                              backgroundColor: Styles.warningButtonColor,
                              afterReset: () {
                                setState(() {});
                              },
                            ),
                            FormSubmitButton(
                              key: submitKey,
                              formKey: formKey,
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              icon: const Icon(Icons.search),
                              labelText: S.of(context).buttonSubmit,
                              afterSubmit: () {
                                widget.visibleController.hide();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
