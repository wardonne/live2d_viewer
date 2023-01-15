import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/constants/destiny_child.dart';
import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/models/destiny_child/character.dart';
import 'package:live2d_viewer/models/live2d_html_data.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/webview_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/preview_windows/snapshot_preview_window.dart';
import 'package:live2d_viewer/widget/preview_windows/video_thumbnail_preview_window.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

class SkinLive2D extends StatefulWidget {
  final Skin skin;
  final WebviewController controller;
  final SnapshotPreviewWindowController snapshotPreviewWindowController;
  final VideoThumbnailPreviewWindowController
      videoThumbnailPreviewWindowController;
  const SkinLive2D({
    super.key,
    required this.skin,
    required this.controller,
    required this.snapshotPreviewWindowController,
    required this.videoThumbnailPreviewWindowController,
  });

  @override
  createState() => SkinLive2DState();
}

class SkinLive2DState extends State<SkinLive2D> {
  @override
  Widget build(BuildContext context) {
    final characterViewController =
        DestinyChildConstants.characterViewController;
    final skin = characterViewController.selectedSkin;
    final settings = watchProvider<SettingsProvider>(context).settings!;
    final destinyChildSettings = settings.destinyChildSettings!;
    final live2dHost = destinyChildSettings.characterSettings!.live2dHost;
    final live2dModel = 'character.DRAGME.${skin.live2d}.json';
    final viewModel = Live2DHtmlData(
      live2d: '$live2dHost/${skin.live2d}/$live2dModel',
    );
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FutureProvider<String>(
                  create: (context) {
                    return rootBundle.loadString(ResourceConstants.live2dHtml);
                  },
                  initialData: '',
                  child: Consumer<String>(
                    builder: (context, data, child) {
                      final host =
                          destinyChildSettings.characterSettings!.virtualHost!;
                      final path =
                          destinyChildSettings.characterSettings!.path!;
                      return WebView(
                        htmlStr: WebviewService.renderHtml(data, viewModel),
                        controller: widget.controller,
                        virtualHosts: [
                          VirtualHost(
                            virtualHost: host,
                            folderPath: path,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SnapshotPreviewWindow(
                    controller: widget.snapshotPreviewWindowController),
                VideoThumbnailPreviewWindow(
                    controller: widget.videoThumbnailPreviewWindowController),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
