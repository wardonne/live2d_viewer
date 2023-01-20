import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/routes.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/nikke/action_model.dart';
import 'package:live2d_viewer/models/nikke/character_model.dart';
import 'package:live2d_viewer/models/nikke/skin_model.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';

class ActionPopupMenu extends StatefulWidget {
  final CharacterModel character;
  const ActionPopupMenu({
    super.key,
    required this.character,
  });

  SkinModel get skin => character.activeSkin;

  List<ActionModel> get actions => skin.actions;

  @override
  State<StatefulWidget> createState() => _ActionPopupMenuState();
}

class _ActionPopupMenuState extends State<ActionPopupMenu> {
  final CustomPopupMenuController menuController = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      barrierColor: Colors.transparent,
      showArrow: false,
      controller: menuController,
      menuBuilder: () => Container(
        width: 150,
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        decoration: const BoxDecoration(
          color: Styles.popupBackgrounColor,
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: widget.actions
              .map((action) => ContainerButton(
                    padding: const EdgeInsets.all(5.0),
                    backgroundColor: Styles.popupBackgrounColor,
                    hoverBackgroundColor: Styles.hoverBackgroundColor,
                    color: Styles.textColor,
                    hoverColor: Styles.hoverTextColor,
                    onClick: () {
                      if (widget.character.activeSkin.activeAction == action) {
                        return;
                      }
                      widget.character.activeSkin.activeActionIndex =
                          widget.actions.indexOf(action);
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.nikkeCharacterDetail,
                        arguments: widget.character,
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.play_arrow_rounded, size: 20),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 9.0),
                            child: Text(
                              action.name,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
      pressType: PressType.singleClick,
      child: Tooltip(
        message: S.of(context).tooltipShowActions,
        child: const Icon(Icons.motion_photos_auto, size: 20),
      ),
    );
  }
}
