import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';
import 'package:live2d_viewer/widget/buttons/image_button.dart';
import 'package:webview_windows/webview_windows.dart';

class MotionPopupMenu extends StatefulWidget {
  final List<String> motions;
  final WebviewController webviewController;
  const MotionPopupMenu({
    super.key,
    required this.motions,
    required this.webviewController,
  });

  @override
  State<StatefulWidget> createState() => _MotionPopupMenuState();
}

class _MotionPopupMenuState extends State<MotionPopupMenu> {
  final CustomPopupMenuController menuController = CustomPopupMenuController();
  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      barrierColor: Colors.transparent,
      showArrow: false,
      controller: menuController,
      menuBuilder: () {
        return Container(
          width: 220,
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          decoration: const BoxDecoration(
            color: Styles.popupBackgrounColor,
            borderRadius: BorderRadius.all(Radius.circular(3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: widget.motions
                .map(
                  (item) => ContainerButton(
                    padding: const EdgeInsets.all(5.0),
                    backgroundColor: Colors.transparent,
                    hoverBackgroundColor: Colors.white24,
                    color: Colors.white,
                    onClick: () async {
                      menuController.hideMenu();
                      await widget.webviewController
                          .executeScript('setMotion("$item")');
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.play_arrow_rounded),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 9.0),
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        ImageButton(
                          icon: const Icon(Icons.videocam),
                          tooltip: S.of(context).tooltipPlayAndRecord,
                          onPressed: () async {
                            menuController.hideMenu();
                            await widget.webviewController
                                .executeScript('recordAnimation("$item")');
                          },
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
      pressType: PressType.singleClick,
      child: const Tooltip(
        message: 'show motions',
        child: Icon(Icons.animation, size: 20),
      ),
    );
  }
}
