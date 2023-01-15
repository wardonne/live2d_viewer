// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/models/settings/settings.dart';
import 'package:live2d_viewer/pages/settings/components/application_settings.dart';
import 'package:live2d_viewer/pages/settings/components/destiny_child_settings.dart';
import 'package:live2d_viewer/pages/settings/components/nikke_settings.dart';
import 'package:live2d_viewer/pages/settings/components/settings_menu.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/dialog/success_dialog.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:provider/provider.dart';

final applicationKey = GlobalKey();
final webviewKey = GlobalKey();

final destinyChildKey = GlobalKey();
final soulCartaKey = GlobalKey();
final destinyChildCharacterKey = GlobalKey();

final nikkeKey = GlobalKey();
final nikkeCharacterKey = GlobalKey();

final _menuItems = [
  SettingMenuItem(anchorKey: applicationKey, label: 'Application'),
  SettingMenuItem(anchorKey: webviewKey, label: 'Webview'),
  SettingMenuItem(
    anchorKey: destinyChildKey,
    label: 'Destiny Child',
    children: [
      SettingMenuItem(
        anchorKey: destinyChildCharacterKey,
        label: 'Child',
      ),
      SettingMenuItem(
        anchorKey: soulCartaKey,
        label: 'Soul Carta',
      ),
    ],
  ),
  SettingMenuItem(
    anchorKey: nikkeKey,
    label: 'Nikke',
    children: [
      SettingMenuItem(
        anchorKey: nikkeCharacterKey,
        label: 'Character',
      ),
    ],
  ),
];

class SettingPage extends StatelessWidget {
  Settings? _settings;

  final formKey = GlobalKey();

  SettingPage({super.key});
  @override
  Widget build(BuildContext context) {
    _settings = watchProvider<SettingsProvider>(context).settings;
    return SizedBox(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                _buildHeader(),
                _buildBody(),
                _buildFooter(context),
              ],
            ),
          ),
          SettingsMenu(items: _menuItems),
        ],
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: _buildForm(),
        ),
      ),
    );
  }

  _buildForm() {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          ApplicationSettingsPage(key: applicationKey, settings: _settings),
          DestinyChildSettingsPage(key: destinyChildKey, settings: _settings),
          NikkeSettingsPage(key: nikkeKey, settings: _settings),
        ],
      ),
    );
  }

  _buildHeader() {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        color: toolbarColor,
        border: Border(
          bottom: BorderSide(color: Colors.white70),
        ),
      ),
      child: const Center(
        child: Text(
          'Settings',
        ),
      ),
    );
  }

  _buildFooter(BuildContext context) {
    return Toolbar.footer(
      height: footerBarHeight,
      borderColor: Colors.white70,
      endActions: [_submitAction(context)],
    );
  }

  _submitAction(BuildContext context) {
    return ImageButton(
      icon: const Icon(
        Icons.save,
        size: 20,
      ),
      onPressed: () async {
        var formContext = formKey.currentState as FormState;
        if (formContext.validate()) {
          try {
            formContext.save();
            await Provider.of<SettingsProvider>(context, listen: false)
                .updateSettings();
            showDialog(
                context: context,
                builder: (context) =>
                    const SuccessDialog(message: 'Update succeeded'));
          } catch (e) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(message: e.toString()),
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return const ErrorDialog(
                message: 'form validated failed',
              );
            },
          );
        }
      },
    );
  }
}
