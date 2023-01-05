import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/settings/settings.dart';
import 'package:live2d_viewer/pages/settings/index.dart';
import 'package:live2d_viewer/widget/form/form_field_with_label.dart';
import 'package:live2d_viewer/widget/form/form_file_picker.dart';
import 'package:live2d_viewer/widget/form/form_text_input.dart';
import 'package:validatorless/validatorless.dart';

class NikkeSettingsPage extends StatelessWidget {
  final TextEditingController characterFolderController =
      TextEditingController();

  final Settings? _settings;

  NikkeSettingsPage({super.key, Settings? settings}) : _settings = settings;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildBasic(),
            _buildCharacter(),
          ],
        ),
      ),
    );
  }

  Widget _buildBasic() {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            'Nikke',
            textAlign: TextAlign.left,
            textScaleFactor: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildCharacter() {
    return Card(
      key: nikkeCharacterKey,
      color: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Text('Character', textScaleFactor: 1.1),
              ),
            ),
            FormFieldWithLabel(
              label: 'Virtual Host',
              field: FormTextInput(
                value: _settings?.nikkeSettings?.characterSettings?.virtualHost,
                onSaved: (value) {
                  _settings?.nikkeSettings?.characterSettings?.virtualHost =
                      value;
                },
                validator: Validatorless.required('Virtual host is required'),
              ),
            ),
            FormFieldWithLabel(
              label: 'Folder',
              field: FormFilePicker(
                controller: characterFolderController,
                value: _settings?.nikkeSettings?.characterSettings?.path,
                onSaved: (value) {
                  _settings?.nikkeSettings?.characterSettings?.path = value;
                },
                validator: Validatorless.required('Folder is required'),
              ),
            ),
            FormFieldWithLabel(
              label: 'Backups',
              field: FormTextInput(
                readOnly: true,
                value: _settings?.nikkeSettings?.characterSettings?.backups,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
