import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/controllers/visible_popup_menu_controller.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:live2d_viewer/widget/wrappers/visible_wrapper.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:live2d_viewer/models/nikke/character.dart' as nikke_character;

class AnimationPopupMenu extends StatefulWidget {
  final VisiblePopupMenuController<String> controller;
  final WebviewController webviewController;
  final nikke_character.Action action;
  const AnimationPopupMenu({
    super.key,
    required this.controller,
    required this.webviewController,
    required this.action,
  });

  @override
  State<StatefulWidget> createState() => _AnimationPopupMenu();
}

class _AnimationPopupMenu extends State<AnimationPopupMenu> {
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
          menuBuilder: () {
            return Container(
              width: 220,
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              decoration: const BoxDecoration(
                color: Color(0xFF4C4C4C),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: widget.controller.items
                    .map((item) => ContainerButton(
                          padding: const EdgeInsets.all(5.0),
                          backgroundColor: Colors.transparent,
                          hoverBackgroundColor: Colors.white24,
                          color: Colors.white,
                          onClick: () async {
                            menuController.hideMenu();
                            await widget.webviewController
                                .executeScript('setAnimation("$item", false)');
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.play_arrow_rounded, size: 20),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Text(
                                    item,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              ImageButton(
                                icon: const Icon(Icons.loop_sharp, size: 20),
                                tooltip: 'loop play',
                                onPressed: () async {
                                  menuController.hideMenu();
                                  await widget.webviewController.executeScript(
                                      'setAnimation("$item", true)');
                                },
                              ),
                              ImageButton(
                                icon: const Icon(Icons.videocam, size: 20),
                                tooltip: 'play and record',
                                onPressed: () async {
                                  menuController.hideMenu();
                                  var newVariable = await widget
                                      .webviewController
                                      .executeScript(
                                          'recordAnimation("$item", false)');
                                  return newVariable;
                                },
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            );
          },
          pressType: PressType.singleClick,
          child: const Tooltip(
            message: 'show animations',
            child: Icon(Icons.animation, size: 20),
          ),
        ),
      ),
    );
  }
}
