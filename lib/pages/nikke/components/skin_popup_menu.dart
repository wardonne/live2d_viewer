import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/iconfont.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/pages/nikke/components/components.dart';

class SkinPopupMenu extends StatefulWidget {
  final Character character;
  final List<Skin> skins;
  const SkinPopupMenu({
    super.key,
    required this.skins,
    required this.character,
  });

  @override
  State<StatefulWidget> createState() {
    return _SkinPopupMenuState();
  }
}

class _SkinPopupMenuState extends State<SkinPopupMenu> {
  final CustomPopupMenuController menuController = CustomPopupMenuController();
  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      menuBuilder: () {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Styles.popupBackgrounColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.skins
                .map((skin) => CharacterCard(
                      character: widget.character,
                      skin: skin,
                    ))
                .toList(),
          ),
        );
      },
      pressType: PressType.singleClick,
      child: Tooltip(
        message: S.of(context).tooltipShowSkins,
        child: const Icon(
          IconFont.iconSkin,
          size: 18,
        ),
      ),
    );
  }
}
