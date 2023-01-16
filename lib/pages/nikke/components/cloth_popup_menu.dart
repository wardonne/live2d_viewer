import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';
import 'package:webview_windows/webview_windows.dart';

class ClothPopupMenu extends StatefulWidget {
  final List<String> clothes;
  final WebviewController webviewController;
  const ClothPopupMenu({
    super.key,
    required this.clothes,
    required this.webviewController,
  });

  @override
  State<StatefulWidget> createState() => _ClothPopupMenuState();
}

class _ClothPopupMenuState extends State<ClothPopupMenu> {
  final CustomPopupMenuController menuController = CustomPopupMenuController();
  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      controller: menuController,
      showArrow: false,
      barrierColor: Colors.transparent,
      pressType: PressType.singleClick,
      menuBuilder: () => Container(
        width: 220,
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        decoration: const BoxDecoration(
          color: Styles.popupBackgrounColor,
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: widget.clothes
              .map(
                (item) => ContainerButton(
                  padding: const EdgeInsets.all(5.0),
                  backgroundColor: Styles.popupBackgrounColor,
                  hoverBackgroundColor: Styles.hoverBackgroundColor,
                  color: Styles.textColor,
                  hoverColor: Styles.hoverTextColor,
                  onClick: () async {
                    menuController.hideMenu();
                    await widget.webviewController
                        .executeScript('setCloth("$item");');
                  },
                  child: Row(children: [
                    const Icon(Icons.play_arrow_rounded, size: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
      child: Tooltip(
        message: S.of(context).tooltipShowClothes,
        child: const Icon(Icons.settings_applications_outlined, size: 20),
      ),
    );
  }
}
