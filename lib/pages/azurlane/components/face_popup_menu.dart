import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/pages/azurlane/components/components.dart';
import 'package:live2d_viewer/widget/widget.dart';

class FacePopupMenu extends StatefulWidget {
  final SkinModel skin;
  final CharacterImageController controller;

  const FacePopupMenu({
    super.key,
    required this.skin,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() {
    return FacePopupMenuState();
  }
}

class FacePopupMenuState extends State<FacePopupMenu> {
  final menuController = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    final skin = widget.skin;
    final faces = skin.faces!;
    final menu = Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Styles.popupBackgrounColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: faces
            .map(
              (face) => Container(
                padding: const EdgeInsets.all(8.0),
                child: ContainerButton(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: Colors.white24,
                      width: 3,
                    ),
                  ),
                  child: CachedNetworkImage(
                    path: skin.faceURL(faces.indexOf(face)),
                    width: 80,
                  ),
                  onClick: () {
                    final index = faces.indexOf(face);
                    skin.enableFace = true;
                    skin.activeFaceIndex = index;
                    widget.controller.value = index;
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
    return CustomPopupMenu(
      controller: menuController,
      showArrow: false,
      barrierColor: Colors.transparent,
      pressType: PressType.singleClick,
      menuBuilder: () => menu,
      child: Tooltip(
        message: S.of(context).tooltipShowExpressions,
        child: const Icon(
          Icons.face_retouching_natural,
        ),
      ),
    );
  }
}
