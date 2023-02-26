import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/iconfont.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/pages/azurlane/components/components.dart';

class SkinPopupMenu extends StatefulWidget {
  final List<SkinModel> skins;
  const SkinPopupMenu({
    super.key,
    required this.skins,
  });

  @override
  State<StatefulWidget> createState() {
    return SkinPopupMenuState();
  }
}

class SkinPopupMenuState extends State<SkinPopupMenu> {
  final scrollController = ScrollController();
  final menuController = CustomPopupMenuController();

  @override
  void dispose() {
    scrollController.dispose();
    menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menu = Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Styles.popupBackgrounColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Listener(
        onPointerSignal: (event) {
          if (event is PointerScrollEvent) {
            scrollController.animateTo(
                scrollController.offset + event.scrollDelta.dy,
                duration: const Duration(milliseconds: 2),
                curve: Curves.bounceIn);
          }
        },
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.skins
                .map((skin) => CharacterCard(
                      character: skin.character,
                      skin: skin,
                    ))
                .toList(),
          ),
        ),
      ),
    );
    return CustomPopupMenu(
      barrierColor: Colors.transparent,
      showArrow: false,
      controller: menuController,
      enablePassEvent: false,
      pressType: PressType.singleClick,
      menuBuilder: () => menu,
      child: Tooltip(
        message: S.of(context).tooltipShowSkins,
        child: const Icon(IconFont.iconSkin),
      ),
    );
  }
}
