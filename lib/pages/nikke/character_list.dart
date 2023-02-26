import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/nikke/character_model.dart';
import 'package:live2d_viewer/pages/nikke/components/character_card.dart';
import 'package:live2d_viewer/services/nikke_service.dart';
import 'package:live2d_viewer/widget/widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterListState();
  }
}

class CharacterListState extends State<CharacterList> {
  final service = NikkeService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).nikke),
        actions: [
          ContainerButton(
            margin: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.refresh),
            onClick: () {
              setState(() {});
            },
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const LanguageSelection(),
          )
        ],
      ),
      body: FutureBuilder(
        future: service.characters(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data!;
            return ListContainer(
              items:
                  items.where((character) => character.enable).map((character) {
                return CharacterCard(character: character);
              }).toList(),
              itemWidth: 100,
              itemHeight: 270,
            );
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            debugPrint('$error');
            return ErrorDialog(
                message: '${S.of(context).requestError}: $error');
          } else {
            final size = MediaQuery.of(context).size;
            return SizedBox(
              width: size.width,
              height: size.height,
              child: LoadingAnimationWidget.threeArchedCircle(
                color: Styles.iconColor,
                size: 30,
              ),
            );
          }
        },
      ),
    );
  }

  Widget characterAvatar(CharacterModel character) {
    final cachedNetworkImageKey = GlobalKey<CachedNetworkImageState>();
    return Center(
      child: SizedBox(
        width: 100,
        height: 200,
        child: ContextMenuWrapper(
          itemBuilder: (context) => [
            RefreshWidgetButton(
              widgetKey: cachedNetworkImageKey,
              title: S.of(context).reload,
              height: 40,
              color: Styles.textColor,
              hoverColor: Styles.hoverTextColor,
              backgroundColor: Styles.popupBackgrounColor,
              hoverBackgroundColor: Styles.hoverBackgroundColor,
              child: Container(
                width: 30,
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: const Icon(Icons.refresh),
              ),
              refreshFunction: () {
                Navigator.of(context).pop(context);
                cachedNetworkImageKey.currentState?.reload();
              },
            ),
          ],
          child: CachedNetworkImage(
            key: cachedNetworkImageKey,
            width: 100,
            height: 200,
            path: character.avatarURL,
            placeholder: ResourceConstants.nikkeCharacterDefaultAvatar,
          ),
        ),
      ),
    );
  }
}
