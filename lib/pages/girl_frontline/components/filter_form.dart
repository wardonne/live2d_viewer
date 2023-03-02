import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/controllers/visible_controller.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/girl_frontline/models.dart';
import 'package:live2d_viewer/pages/girl_frontline/components/components.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/wrappers/wrapper.dart';

class FilterForm extends StatefulWidget {
  final VisibleController visibleController;
  final ValueNotifyWrapper<FilterFormModel> filterController;
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
  final nameKey = GlobalKey<FilterFormNameInputState>();
  final rankKey = GlobalKey<FilterFormRankSelectionState>();
  final typeKey = GlobalKey<FilterFormTypeSelectionState>();
  final submitKey = GlobalKey<FormSubmitButtonState>();
  late final FilterFormModel model;

  @override
  void initState() {
    super.initState();
    model = widget.filterController.value;
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterFormNameInput(key: nameKey, model: model),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterFormRankSelection(model: model),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterFormTypeSelection(model: model),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonBar(
                    children: [
                      FormResetButton(
                        formKey: formKey,
                        height: 50,
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        icon: const Icon(Icons.replay_outlined),
                        labelText: S.of(context).buttonReset,
                        backgroundColor: Styles.warningButtonColor,
                        afterReset: () {
                          model.reset();
                          setState(() {});
                        },
                      ),
                      FormSubmitButton(
                        key: submitKey,
                        formKey: formKey,
                        height: 50,
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        icon: const Icon(Icons.search),
                        labelText: S.of(context).buttonSubmit,
                        afterSubmit: () {
                          widget.visibleController.hide();
                          widget.filterController.value =
                              FilterFormModel.from(model);
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
    );
  }
}
