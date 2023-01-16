import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/language_selection.dart';
import 'package:live2d_viewer/components/webview_console_button.dart';
import 'package:live2d_viewer/components/webview_refresh_button.dart';
import 'package:live2d_viewer/constants/application.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/controllers/visible_popup_menu_controller.dart';
import 'package:live2d_viewer/models/nikke/character.dart';
import 'package:live2d_viewer/models/virtual_host.dart';
import 'package:live2d_viewer/pages/destiny_child/components/zoom_popup_control.dart';
import 'package:live2d_viewer/pages/nikke/components/action_popup_menu.dart';
import 'package:live2d_viewer/pages/nikke/components/animation_popup_menu.dart';
import 'package:live2d_viewer/pages/nikke/components/cloth_popup_menu.dart';
import 'package:live2d_viewer/pages/nikke/components/speed_popup_control.dart';
import 'package:live2d_viewer/services/nikke/nikke_service.dart';
import 'package:live2d_viewer/widget/dialog/error_dialog.dart';
import 'package:live2d_viewer/widget/toolbar.dart';
import 'package:live2d_viewer/widget/webview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:webview_windows/webview_windows.dart';

class CharacterDetail extends StatefulWidget {
  const CharacterDetail({super.key});

  @override
  State<StatefulWidget> createState() {
    return CharacterDetailState();
  }
}

class CharacterDetailState extends State<CharacterDetail> {
  final service = NikkeService();
  final WebviewController _controller = WebviewController();
  final VisiblePopupMenuController<String> _animationController =
      VisiblePopupMenuController<String>(items: [], visible: false);
  final VisiblePopupMenuController<String> _clothController =
      VisiblePopupMenuController<String>(items: [], visible: false);
  @override
  void initState() {
    super.initState();
    _controller.webMessage.listen((messages) {
      final event = messages['event'] as String;
      debugPrint(event);
      final data = messages['data'];
      switch (event) {
        case 'animations':
          final items = data['items'];
          _animationController.setData(
              (items as List<dynamic>).map((item) => item as String).toList());
          break;
        case 'clothes':
          final items = data['items'];
          _clothController.setData(
              (items as List<dynamic>).map((item) => item as String).toList());
          break;
        case 'snapshot':
          break;
        case 'video':
          break;
        default:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)?.settings.arguments as Character;
    debugPrint('character: $character');
    final skin = character.activeSkin;
    final action = skin.activeAction;
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: LanguageSelection(),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Toolbar(
          height: Styles.bottomAppBarHeight,
          decoration: const BoxDecoration(
            color: Styles.appBarColor,
          ),
          endActions: [
            ZoomPopupControl(
              value: 1.0,
              max: 3.0,
              min: 0.5,
              webviewController: _controller,
            ),
            SpeedPopupControl(
              value: 1.0,
              max: 2.0,
              min: 0.5,
              webviewController: _controller,
            ),
            if (skin.actions.length > 1) ActionPopupMenu(character: character),
            AnimationPopupMenu(
              controller: _animationController,
              webviewController: _controller,
              action: action,
            ),
            ClothPopupMenu(
              controller: _clothController,
              webviewController: _controller,
              action: action,
            ),
            WebviewRefreshButton(controller: _controller),
            WebviewConsoleButton(controller: _controller),
          ],
        ),
      ),
      body: FutureBuilder(
        future: service.loadHtml(skin, action),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final html = snapshot.data!;
            final virtualHost = VirtualHost(
              virtualHost: ApplicationConstants.localAssetsURL,
              folderPath: service.getCachePath(skin.code, action.name),
            );
            debugPrint(virtualHost.toString());
            return WebView(
              controller: _controller,
              htmlStr: html,
              virtualHosts: [virtualHost],
            );
          } else if (snapshot.hasError) {
            return ErrorDialog(message: snapshot.error!.toString());
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

class CharacterOptionController extends ChangeNotifier {
  List<String> animations;
  List<String> clothes;
  bool visible;

  CharacterOptionController({
    required this.animations,
    required this.clothes,
    this.visible = false,
  });

  setAnimations(List<String> animations) {
    this.animations = animations;
    if (clothes.isNotEmpty) {
      notifyListeners();
    }
  }

  setClothes(List<String> clothes) {
    this.clothes = clothes;
    if (animations.isNotEmpty) {
      notifyListeners();
    }
  }
}
