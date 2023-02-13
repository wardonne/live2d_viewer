import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/pages/girl_frontline/components/character_card.dart';
import 'package:live2d_viewer/services/girl_frontline_service.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterListState();
  }
}

class CharacterListState extends RefreshableState<CharacterList> {
  final service = GirlFrontlineService();

  bool _reload = false;

  @override
  void reload({bool forceReload = false}) {
    setState(() {
      _reload = forceReload;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).girlFrontline),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: ToolbarRefreshButton(widgetState: this),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const LanguageSelection(),
          )
        ],
      ),
      body: FutureBuilder(
        future: service.characters(reload: _reload),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final items = snapshot.data!;
            return ListContainer(
              items: items.where((item) => item.code == 'dsr50').map((item) {
                return CharacterCard(
                  character: item,
                );
              }).toList(),
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
}
