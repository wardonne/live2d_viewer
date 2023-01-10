import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/constants/nikke.dart';
import 'package:live2d_viewer/constants/resources.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/spine_html_data.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/services/webview_service.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/preview_windows/snapshot_preview_window.dart';
import 'package:live2d_viewer/widget/preview_windows/video_thumbnail_preview_window.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:provider/provider.dart';
import 'package:webview_windows/webview_windows.dart';

class SkinSpine extends StatefulWidget {
  final Skin skin;
  final WebviewController controller;
  final SnapshotPreviewWindowController snapshotPreviewWindowController;
  final VideoThumbnailPreviewWindowController
      videoThumbnailPreviewWindowController;
  const SkinSpine({
    super.key,
    required this.skin,
    required this.controller,
    required this.snapshotPreviewWindowController,
    required this.videoThumbnailPreviewWindowController,
  });

  @override
  State<StatefulWidget> createState() {
    return SkinSpineState();
  }
}

class SkinSpineState extends State<SkinSpine> {
  @override
  Widget build(BuildContext context) {
    final characterViewController = NikkeConstants.characterViewController;
    final skin = characterViewController.selectedSkin;
    final settings = watchProvider<SettingsProvider>(context).settings!;
    final nikkeSettings = settings.nikkeSettings!;
    final webviewSettings = settings.webviewSettings!;
    final spineHost = nikkeSettings.characterSettings!.spineHost;
    final action = characterViewController.action;
    final viewModel = SpineHtmlData(
      atlasUrl: '$spineHost/${skin.code}/${action.atlas}',
      skelUrl: '$spineHost/${skin.code}/${action.skel}',
      animation: action.animation,
      webviewHost: webviewSettings.virtualHost,
    );
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                FutureProvider(
                  create: (context) =>
                      rootBundle.loadString(spineVersion40Html),
                  initialData: '',
                  child: Consumer<String>(
                    builder: (context, data, child) {
                      final host =
                          nikkeSettings.characterSettings!.virtualHost!;
                      final path = nikkeSettings.characterSettings!.path!;
                      return WebView(
                        controller: widget.controller,
                        htmlStr: WebviewService.renderHtml(data, viewModel),
                        virtualHosts: [
                          VirtualHost(
                              virtualHost: webviewSettings.virtualHost!,
                              folderPath: webviewSettings.path!),
                          VirtualHost(virtualHost: host, folderPath: path),
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
          )
        ],
      ),
    );
  }
}
