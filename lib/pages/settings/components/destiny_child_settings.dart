import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/models/settings/settings.dart';
import 'package:live2d_viewer/pages/settings/index.dart';
import 'package:live2d_viewer/widget/form/form_dropdown.dart';
import 'package:live2d_viewer/widget/form/form_field_with_label.dart';
import 'package:live2d_viewer/widget/form/form_file_picker.dart';
import 'package:live2d_viewer/widget/form/form_text_input.dart';
import 'package:validatorless/validatorless.dart';

class DestinyChildSettingsPage extends StatelessWidget {
  final TextEditingController soulCartaFolderController =
      TextEditingController();

  final TextEditingController childFolderController = TextEditingController();

  final Settings? _settings;

  DestinyChildSettingsPage({super.key, required Settings? settings})
      : _settings = settings;

  @override
  Widget build(BuildContext context) {
    return _buildDestinyChild();
  }

  Widget _buildDestinyChild() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildBasic(),
            _buildCharacter(),
            _buildSoulCarta(),
          ],
        ),
      ),
    );
  }

  Widget _buildBasic() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 20),
          child: Text(
            'Destiny Child',
            textAlign: TextAlign.left,
            textScaleFactor: 1.2,
          ),
        ),
        FormFieldWithLabel(
          label: 'Live2D Version',
          field: FormDropdown<String>(
            value: _settings?.destinyChildSettings?.live2dVersion,
            items: const [
              DropdownMenuItem(
                value: '2',
                child: Text('Version 2'),
              ),
              DropdownMenuItem(
                value: '3',
                child: Text('Version 3'),
              ),
            ],
            onChanged: (value) {},
            onSaved: (value) {
              _settings?.destinyChildSettings?.live2dVersion = value!;
            },
            validator: Validatorless.required('Live2D version is required'),
          ),
        ),
        FormFieldWithLabel(
          label: 'Default Home',
          field: FormDropdown(
            value: _settings?.destinyChildSettings?.defaultHome,
            items: DestinyChildConstants.tabbars
                .map(
                  (value) => DropdownMenuItem(
                      value: DestinyChildConstants.tabbars.indexOf(value),
                      child: value),
                )
                .toList(),
            onChanged: (value) {},
            onSaved: (value) {
              _settings?.destinyChildSettings?.defaultHome =
                  value ?? DestinyChildConstants.defaultHome;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSoulCarta() {
    return Card(
      key: soulCartaKey,
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Soul Carta',
                textScaleFactor: 1.1,
              ),
            ),
            FormFieldWithLabel(
              label: 'Virtual Host',
              field: FormTextInput(
                value: _settings
                    ?.destinyChildSettings?.soulCartaSettings?.virtualHost,
                onSaved: (value) {
                  _settings?.destinyChildSettings?.soulCartaSettings
                      ?.virtualHost = value;
                },
                validator: Validatorless.required('Virtual host is required'),
              ),
            ),
            FormFieldWithLabel(
              label: 'Folder',
              field: FormFilePicker(
                value: _settings?.destinyChildSettings?.soulCartaSettings?.path,
                controller: soulCartaFolderController,
                onSaved: (value) {
                  _settings?.destinyChildSettings?.soulCartaSettings?.path =
                      value;
                },
                validator: Validatorless.required('Folder is required'),
              ),
            ),
            FormFieldWithLabel(
              label: 'Backups',
              field: FormTextInput(
                readOnly: true,
                value:
                    _settings?.destinyChildSettings?.characterSettings?.backups,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacter() {
    return Card(
      key: destinyChildCharacterKey,
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Child',
                textScaleFactor: 1.1,
              ),
            ),
            FormFieldWithLabel(
              label: 'Virtual Host',
              field: FormTextInput(
                value: _settings
                    ?.destinyChildSettings?.characterSettings?.virtualHost,
                onSaved: (value) {
                  _settings?.destinyChildSettings?.characterSettings
                      ?.virtualHost = value;
                },
                validator: Validatorless.required('Virtual host is required'),
              ),
            ),
            FormFieldWithLabel(
              label: 'Folder',
              field: FormFilePicker(
                value: _settings?.destinyChildSettings?.characterSettings?.path,
                controller: childFolderController,
                onSaved: (value) {
                  _settings?.destinyChildSettings?.characterSettings?.path =
                      value;
                },
                validator: Validatorless.required('Folder is required'),
              ),
            ),
            FormFieldWithLabel(
              label: 'Backups',
              field: FormTextInput(
                readOnly: true,
                value:
                    _settings?.destinyChildSettings?.characterSettings?.backups,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
