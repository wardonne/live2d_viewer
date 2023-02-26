import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:webview_windows/webview_windows.dart';

class AnimationPopupMenu extends StatefulWidget {
  final WebviewController webviewController;
  final List<String> animations;
  const AnimationPopupMenu({
    super.key,
    required this.webviewController,
    required this.animations,
  });

  @override
  State<StatefulWidget> createState() {
    return AnimationPopupMenuState();
  }
}

class AnimationPopupMenuState extends State<AnimationPopupMenu> {
  final CustomPopupMenuController menuController = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      controller: menuController,
      showArrow: false,
      barrierColor: Colors.transparent,
      menuBuilder: () {
        return Container(
          width: 220,
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          decoration: const BoxDecoration(
            color: Styles.popupBackgrounColor,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          constraints: const BoxConstraints(
            maxHeight: 300,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: widget.animations
                  .map((item) => ContainerButton(
                        padding: const EdgeInsets.all(5.0),
                        backgroundColor: Styles.popupBackgrounColor,
                        hoverBackgroundColor: Styles.hoverBackgroundColor,
                        color: Styles.textColor,
                        hoverColor: Styles.hoverTextColor,
                        onClick: () async {
                          menuController.hideMenu();
                          await widget.webviewController
                              .executeScript('setAnimation("$item", false)');
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.play_arrow_rounded),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Text(item),
                              ),
                            ),
                            ImageButton(
                              icon: const Icon(Icons.loop_sharp),
                              tooltip: S.of(context).tooltipLoopPlay,
                              onPressed: () async {
                                menuController.hideMenu();
                                await widget.webviewController.executeScript(
                                    'setAnimation("$item", true)');
                              },
                            ),
                            ImageButton(
                              icon: const Icon(Icons.videocam, size: 20),
                              tooltip: S.of(context).tooltipPlayAndRecord,
                              onPressed: () async {
                                menuController.hideMenu();
                                var newVariable = await widget.webviewController
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
          ),
        );
      },
      pressType: PressType.singleClick,
      child: Tooltip(
        message: S.of(context).tooltipShowAnimation,
        child: const Icon(Icons.animation),
      ),
    );
  }
}
