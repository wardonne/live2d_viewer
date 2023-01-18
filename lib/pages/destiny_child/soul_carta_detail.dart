import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/destiny_child/soul_carta.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/services/destiny_child_service.dart';
import 'package:live2d_viewer/services/http_service.dart';
import 'package:live2d_viewer/widget/dialog/dialog.dart';
import 'package:live2d_viewer/widget/image_viewer.dart';
import 'package:live2d_viewer/widget/live2d_viewer.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:webview_windows/webview_windows.dart';

class SoulCartaDetail extends StatefulWidget {
  const SoulCartaDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return SoulCartaDetailState();
  }
}

class SoulCartaDetailState extends State<SoulCartaDetail> {
  final HTTPService http = HTTPService();
  final DestinyChildService service = DestinyChildService();

  @override
  Widget build(BuildContext context) {
    final webviewController = WebviewController();
    final soulCarta = ModalRoute.of(context)!.settings.arguments as SoulCarta;
    return Scaffold(
      appBar: AppBar(
        title: Text(soulCarta.name ?? ''),
      ),
      bottomNavigationBar: Toolbar(
        height: Styles.bottomAppBarHeight,
        color: Styles.appBarColor,
        endActions: [
          if (soulCarta.useLive2d) ...[
            WebviewRefreshButton(controller: webviewController),
            WebviewConsoleButton(controller: webviewController),
          ],
        ],
      ),
      body: FutureBuilder(
        future: soulCarta.useLive2d
            ? service.loadSoulCartaHTML(
                soulCarta: soulCarta,
                baseURL:
                    '${DestinyChildConstants.soulCartaLive2DURL}/${soulCarta.live2d!}',
                model: service.getModelJSON(soulCarta.live2d!),
              )
            : http.downloadImage(soulCarta.imageURL),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorDialog(message: snapshot.error.toString());
          } else if (snapshot.hasData) {
            return soulCarta.useLive2d
                ? Live2DViewer(
                    controller: webviewController,
                    html: snapshot.data! as String,
                    virtualHosts: [
                      VirtualHost(
                        virtualHost: ApplicationConstants.localAssetsURL,
                        folderPath: soulCarta.cachePath,
                      ),
                    ],
                  )
                : ImageViewer(image: snapshot.data! as File);
          } else {
            return const LoadingAnimation(size: 30.0);
          }
        },
      ),
    );
  }
}
