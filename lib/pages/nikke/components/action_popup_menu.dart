import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/routes.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';
import 'package:live2d_viewer/models/nikke/character.dart' as nikke;

class ActionPopupMenu extends StatefulWidget {
  final nikke.Character character;
  const ActionPopupMenu({
    super.key,
    required this.character,
  });

  nikke.Skin get skin => character.activeSkin;

  List<nikke.Action> get actions => skin.actions;

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
          color: Color(0xFF4C4C4C),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: widget.actions
              .map((action) => ContainerButton(
                    padding: const EdgeInsets.all(5.0),
                    backgroundColor: Colors.transparent,
                    hoverBackgroundColor: Colors.white24,
                    color: Colors.white,
                    onClick: () {
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
      child: const Tooltip(
        message: 'show actions',
        child: Icon(Icons.motion_photos_auto, size: 20),
      ),
    );
  }
}
