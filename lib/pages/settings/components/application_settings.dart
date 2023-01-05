import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/sidebar.dart';
import 'package:live2d_viewer/models/settings/settings.dart';
import 'package:live2d_viewer/widget/form/form_dropdown.dart';
import 'package:live2d_viewer/widget/form/form_field_with_label.dart';
import 'package:validatorless/validatorless.dart';

class ApplicationSettingsPage extends StatelessWidget {
  final Settings? _settings;

  const ApplicationSettingsPage({super.key, required Settings? settings})
      : _settings = settings;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Text(
                'Application',
                textAlign: TextAlign.center,
                textScaleFactor: 1.2,
              ),
            ),
            FormFieldWithLabel(
                label: 'Default Home',
                field: FormDropdown<String>(
                  value: _settings?.applicationSettings?.defaultSidebar,
                  items: sidebarItems
                      .map((item) => DropdownMenuItem(
                            value: sidebarItems.indexOf(item).toString(),
                            child: Text(item.title),
                          ))
                      .toList(),
                  onChanged: (value) {},
                  onSaved: (value) =>
                      _settings?.applicationSettings?.defaultSidebar = value,
                  validator: Validatorless.required('Default home is required'),
                )),
          ],
        ),
      ),
    );
  }
}
