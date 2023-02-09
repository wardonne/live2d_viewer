import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/controllers/hover_controller.dart';
import 'package:live2d_viewer/controllers/load_controller.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/girl_frontline/character_model.dart';
import 'package:live2d_viewer/models/girl_frontline/skin_model.dart';
import 'package:live2d_viewer/pages/girl_frontline/components/components.dart';
import 'package:live2d_viewer/widget/buttons/buttons.dart';
import 'package:live2d_viewer/widget/wrappers/context_menu_wrapper.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CharacterCard extends StatefulWidget {
  final CharacterModel character;
  final SkinModel? skin;
  const CharacterCard({
    super.key,
    required this.character,
    this.skin,
  });

  @override
  State<StatefulWidget> createState() {
    return CharacterCardState();
  }
}

class CharacterCardState extends State<CharacterCard> {
  final controller = LoadController();

  final hoverController = HoverController(false);

  late final CharacterModel character;

  late final bool isSkin;

  late final SkinModel? skin;

  @override
  initState() {
    super.initState();
    character = widget.character;
    skin = widget.skin;
    isSkin = skin != null;
  }

  _toDetail() {
    if (isSkin) {
      if (character.activeSkin != skin) {
        character.switchSkin(skin!);
        Navigator.pushReplacementNamed(
          context,
          Routes.girlFrontlineCharacterDetail,
          arguments: widget.character,
        );
      }
    } else {
      Navigator.pushNamed(
        context,
        Routes.girlFrontlineCharacterDetail,
        arguments: widget.character,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<CharacterAvatarState>();
    final characterAvatar = CharacterAvatar(
      key: key,
      avatar: character.isDestoryMode
          ? (isSkin ? skin!.destroyAvatar : character.destroyAvatar)
          : (isSkin ? skin!.normalAvatar : character.normalAvatar),
      hoverAvatar: character.isDestoryMode
          ? (isSkin ? skin!.normalAvatar : character.normalAvatar)
          : (isSkin ? skin!.destroyAvatar : character.destroyAvatar),
      controller: controller,
      hoverController: hoverController,
    );
    final refreshButton = RefreshWidgetButton(
      height: 40.0,
      backgroundColor: Styles.popupBackgrounColor,
      hoverBackgroundColor: Styles.hoverBackgroundColor,
      color: Styles.textColor,
      hoverColor: Styles.hoverTextColor,
      title: S.of(context).reload,
      beforeRefresh: Navigator.of(context).pop,
      refreshFunction: () {
        controller.reload = true;
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: const Icon(Icons.refresh),
      ),
    );
    return MouseRegion(
      onEnter: (event) => hoverController.value = true,
      onExit: (event) => hoverController.value = false,
      child: ContainerButton(
        width: 170,
        height: 320,
        padding: const EdgeInsets.all(10.0),
        backgroundColor: Colors.transparent,
        hoverBackgroundColor: Colors.transparent,
        onClick: _toDetail,
        child: Stack(
          children: [
            VisibilityDetector(
              key: ObjectKey(isSkin ? widget.skin : widget.character),
              onVisibilityChanged: (VisibilityInfo info) {
                controller.load = true;
              },
              child: isSkin
                  ? characterAvatar
                  : ContextMenuWrapper(
                      itemBuilder: (context) {
                        return [refreshButton];
                      },
                      child: Center(child: characterAvatar),
                    ),
            ),
            Positioned(
              top: 232,
              width: 170,
              child: CharacterName(
                name: isSkin ? skin!.name : character.name,
                character: character,
              ),
            ),
            Positioned(
              top: -2.5,
              right: 0,
              child: CharacterStar(rank: character.rank),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: CharacterType(
                character: character,
              ),
            ),
            if (isSkin && skin!.hasLive2d)
              Positioned(
                right: 5,
                bottom: 5,
                child: Image.asset(
                  ResourceConstants.girlFrontlineLive2DFilterLogo,
                  height: 20.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
