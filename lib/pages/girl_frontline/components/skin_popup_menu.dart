import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/girl_frontline/skin_model.dart';
import 'package:live2d_viewer/pages/girl_frontline/components/character_card.dart';

class SkinPopupMenu extends StatefulWidget {
  final List<SkinModel> skins;

  const SkinPopupMenu({super.key, required this.skins});

  @override
  State<StatefulWidget> createState() {
    return SkinPopupMenuState();
  }
}

class SkinPopupMenuState extends State<SkinPopupMenu> {
  final menuController = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      barrierColor: Colors.transparent,
      showArrow: false,
      controller: menuController,
      enablePassEvent: false,
      menuBuilder: () {
        return Container(
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            color: Styles.popupBackgrounColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.skins
                .map(
                  (skin) => CharacterCard(
                    character: skin.character,
                    skin: skin,
                  ),
                )
                .toList(),
          ),
        );
      },
      pressType: PressType.singleClick,
      child: Tooltip(
        message: S.of(context).tooltipShowSkins,
        child: Image.asset(
          ResourceConstants.girlFrontlineSkinFilterLogo,
          width: 20.0,
        ),
      ),
    );
  }
}
