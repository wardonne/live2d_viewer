import 'package:flutter/material.dart';
import 'package:live2d_viewer/controllers/visible_popup_menu_controller.dart';
import 'package:live2d_viewer/widget/wrappers/visible_wrapper.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:live2d_viewer/models/nikke/character.dart' as nikke_character;

class ClothPopupMenu extends StatelessWidget {
  final VisiblePopupMenuController<String> controller;
  final WebviewController webviewController;
  final nikke_character.Action action;
  const ClothPopupMenu({
    super.key,
    required this.controller,
    required this.webviewController,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return VisibleWrapper(
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.only(left: 7.5, right: 7.5),
        child: PopupMenuButton(
          splashRadius: 20,
          tooltip: 'show clothes',
          child: const Icon(Icons.settings_applications_outlined, size: 20),
          itemBuilder: (context) => controller.items
              .map((item) => PopupMenuItem(
                    height: 15,
                    child: Padding(
                        padding: const EdgeInsets.all(5), child: Text(item)),
                    onTap: () async {
                      await webviewController
                          .executeScript('setCloth("$item");');
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}
