import 'package:flutter/material.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/controllers/load_controller.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/pages/azurlane/components/components.dart';
import 'package:live2d_viewer/widget/widget.dart';
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
          Routes.azurlaneCharacterDetail,
          arguments: widget.character,
        );
      }
    } else {
      Navigator.pushNamed(
        context,
        Routes.azurlaneCharacterDetail,
        arguments: widget.character,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double width = 120;
    const double height = 220;
    final key = GlobalKey<CharacterAvatarState>();
    final avatar = isSkin ? skin!.avatarURL : character.avatarURL;
    final rarity = isSkin ? skin!.shipRarity : character.shipRarity;
    final avatarFrame = rarity.avatarFrame;
    final avatarBackground = rarity.avatarBackground;
    final characterAvatar = CharacterAvatar(
      key: key,
      avatar: avatar,
      avatarFrame: avatarFrame,
      avatarBackground: avatarBackground,
      controller: controller,
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
      child: ContainerButton(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10.0),
        backgroundColor: Colors.transparent,
        hoverBackgroundColor: Styles.hoverBackgroundColor,
        isHover: isSkin ? character.activeSkin == skin! : false,
        onClick: _toDetail,
        child: Column(
          children: [
            VisibilityDetector(
              key: ObjectKey(isSkin ? widget.skin : widget.character),
              onVisibilityChanged: (VisibilityInfo info) {
                controller.load = true;
              },
              child: isSkin
                  ? characterAvatar
                  : ContextMenuWrapper(
                      child: Center(
                        child: characterAvatar,
                      ),
                      itemBuilder: (context) {
                        return [refreshButton];
                      },
                    ),
            ),
            const Divider(
              height: 2,
              color: Colors.transparent,
            ),
            Center(
              child: Text(
                isSkin ? skin!.name : character.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
