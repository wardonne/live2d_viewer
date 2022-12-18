import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/settings.dart';
import 'package:live2d_viewer/widget/form/form_field_with_label.dart';
import 'package:live2d_viewer/widget/form/form_file_picker.dart';
import 'package:live2d_viewer/widget/form/form_text_input.dart';
import 'package:validatorless/validatorless.dart';

class WebviewSettingsPage extends StatelessWidget {
  final TextEditingController webviewFolderController = TextEditingController();

  final Settings? _settings;

  WebviewSettingsPage({super.key, required Settings? settings})
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
                'Webview',
                textAlign: TextAlign.left,
                textScaleFactor: 1.2,
              ),
            ),
            FormFieldWithLabel(
              label: 'Virtual Host',
              field: FormTextInput(
                value: _settings?.webviewSettings?.virtualHost,
                onSaved: (value) {
                  _settings?.webviewSettings?.virtualHost = value;
                },
                validator: Validatorless.required('Virtual host is required'),
              ),
            ),
            FormFieldWithLabel(
              label: 'Folder',
              field: FormFilePicker(
                value: _settings?.webviewSettings?.path,
                controller: webviewFolderController,
                onSaved: (value) {
                  _settings?.webviewSettings?.path = value;
                },
                validator: Validatorless.required('Folder is required'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
