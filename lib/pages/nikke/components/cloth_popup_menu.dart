import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/controllers/visible_popup_menu_controller.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';
import 'package:live2d_viewer/widget/wrappers/visible_wrapper.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:live2d_viewer/models/nikke/character.dart' as nikke_character;

class ClothPopupMenu extends StatefulWidget {
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
  State<StatefulWidget> createState() => _ClothPopupMenuState();
}

class _ClothPopupMenuState extends State<ClothPopupMenu> {
  final CustomPopupMenuController menuController = CustomPopupMenuController();
  @override
  Widget build(BuildContext context) {
    return VisibleWrapper(
      controller: widget.controller,
      child: Padding(
        padding: const EdgeInsets.only(left: 7.5, right: 7.5),
        child: CustomPopupMenu(
          controller: menuController,
          showArrow: false,
          barrierColor: Colors.transparent,
          pressType: PressType.singleClick,
          menuBuilder: () => Container(
            width: 220,
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            decoration: const BoxDecoration(
              color: Color(0xFF4C4C4C),
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: widget.controller.items
                  .map(
                    (item) => ContainerButton(
                      padding: const EdgeInsets.all(5.0),
                      backgroundColor: Colors.transparent,
                      hoverBackgroundColor: Colors.white24,
                      color: Colors.white,
                      onClick: () async {
                        menuController.hideMenu();
                        await widget.webviewController
                            .executeScript('setCloth("$item");');
                      },
                      child: Row(children: [
                        const Icon(Icons.play_arrow_rounded, size: 20),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  )
                  .toList(),
            ),
          ),
          child: const Tooltip(
            message: 'show clothes',
            child: Icon(Icons.settings_applications_outlined, size: 20),
          ),
        ),
      ),
    );
  }
}
