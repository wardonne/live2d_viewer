import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/language_selection.dart';
import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/constants/routes.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/services/nikke/nikke_service.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';
import 'package:live2d_viewer/widget/cached_network_image.dart';
import 'package:live2d_viewer/widget/wrappers/context_menu_wrapper.dart';
import 'package:provider/provider.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterListState();
  }
}

class CharacterListState extends State<CharacterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).nikke),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const LanguageSelection(),
          )
        ],
      ),
      body: FutureProvider<List<Character>>(
        create: (BuildContext context) {
          return NikkeService.characters();
        },
        initialData: const [],
        child: Consumer<List<Character>>(
          builder: (BuildContext context, items, Widget? child) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: items.where((item) => item.enable).map((item) {
                    return ContainerButton(
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.transparent,
                      hoverBackgroundColor: Colors.white12,
                      onClick: () {
                        Navigator.pushNamed(
                          context,
                          Routes.nikkeCharacterDetail,
                          arguments: item,
                        );
                      },
                      child: Column(
                        children: [
                          characterAvatar(item),
                          const Divider(height: 2, color: Colors.transparent),
                          Center(child: Text(item.name))
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget characterAvatar(Character item) {
    final cachedNetworkImageKey = GlobalKey<CachedNetworkImageState>();
    return Center(
      child: SizedBox(
        width: 100,
        height: 200,
        child: ContextMenuWrapper(
          itemBuilder: (context) => [
            ListTile(
              leading: const Icon(Icons.refresh),
              title: Text(S.of(context).reload),
              onTap: () {
                Navigator.of(context).pop();
                cachedNetworkImageKey.currentState?.reload();
              },
            )
          ],
          child: CachedNetworkImage(
            key: cachedNetworkImageKey,
            width: 100,
            height: 200,
            path:
                'https://static.wardonet.cn/live2d-viewer/assets/nikke/character/avatars/${item.avatar}',
            placeholder: ResourceConstants.nikkeCharacterDefaultAvatar,
          ),
        ),
      ),
    );
  }
}
