import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/destiny_child/soul_carta_model.dart';
import 'package:live2d_viewer/services/destiny_child_service.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:live2d_viewer/states/refreshable_state.dart';
import 'package:live2d_viewer/widget/widget.dart';
import 'package:webview_windows/webview_windows.dart';

class SoulCartaDetail extends StatefulWidget {
  const SoulCartaDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return SoulCartaDetailState();
  }
}

class SoulCartaDetailState extends RefreshableState<SoulCartaDetail> {
  final HTTPService http = HTTPService();
  final DestinyChildService service = DestinyChildService();

  bool _reload = false;

  @override
  void reload({bool forceReload = false}) {
    setState(() {
      _reload = forceReload;
    });
  }

  @override
  Widget build(BuildContext context) {
    final webviewController = WebviewController();
    final soulCarta =
        ModalRoute.of(context)!.settings.arguments as SoulCartaModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(soulCarta.name),
      ),
      bottomNavigationBar: Toolbar(
        height: Styles.bottomAppBarHeight,
        color: Styles.appBarColor,
        endActions: [
          ToolbarRefreshButton(widgetState: this),
          if (soulCarta.useLive2d)
            WebviewConsoleButton(controller: webviewController),
        ],
      ),
      body: FutureBuilder(
        future: soulCarta.useLive2d
            ? service.loadSoulCartaHTML(soulCarta)
            : http.download(soulCarta.imageURL, reload: _reload),
        builder: (context, snapshot) {
          const loading = LoadingAnimation(size: 30.0);
          if (snapshot.connectionState != ConnectionState.done) {
            return loading;
          }
          if (snapshot.hasError) {
            return ErrorDialog(message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            return soulCarta.useLive2d
                ? Live2DViewer(
                    controller: webviewController,
                    html: snapshot.data! as String,
                    virtualHosts: [ApplicationConstants.virtualHost],
                  )
                : ImageViewer(image: snapshot.data! as File);
          } else {
            return loading;
          }
        },
      ),
    );
  }
}
