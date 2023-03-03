import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/models/girl_frontline/character_model.dart';
import 'package:live2d_viewer/pages/girl_frontline/character_detail.dart';
import 'package:live2d_viewer/services/girl_frontline_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';
import 'package:live2d_viewer/widget/spine_viewer.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

class CharacterSpine extends StatefulWidget {
  final CharacterModel character;
  final WebviewController controller;
  final bool reload;
  const CharacterSpine({
    super.key,
    required this.character,
    required this.controller,
    required this.reload,
  });

  @override
  State<StatefulWidget> createState() {
    return CharacterSpineState();
  }
}

class CharacterSpineState extends State<CharacterSpine> {
  final service = GirlFrontlineService();
  late WebviewController controller;
  late bool _isDestory;

  @override
  initState() {
    super.initState();
    _isDestory = widget.character.isDestoryMode;
  }

  switchMode() {
    setState(() {
      _isDestory = !_isDestory;
    });
  }

  @override
  Widget build(BuildContext context) {
    controller = widget.controller;
    final normalSpine = widget.character.activeSkin.spine!['normal']!;
    final restSpine = widget.character.activeSkin.spine!['rest']!;
    final isRest = context.watch<CharacterDetailController>().isRest;
    return FutureBuilder(
      future: service.loadSpineHtml(
        isRest ? restSpine : normalSpine,
        reload: widget.reload,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingAnimation(size: 30.0);
        }
        if (snapshot.hasData) {
          final html = snapshot.data!;
          return SpineViewer(
            controller: controller,
            html: html,
            virtualHosts: [ApplicationConstants.virtualHost],
          );
        } else if (snapshot.hasError) {
          return ErrorDialog(message: '${snapshot.error}');
        } else {
          return const LoadingAnimation(size: 30.0);
        }
      },
    );
  }
}
