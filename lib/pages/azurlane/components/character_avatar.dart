import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/azurlane.dart';
import 'package:live2d_viewer/controllers/load_controller.dart';
import 'package:live2d_viewer/queue/queue.dart';
import 'package:live2d_viewer/services/http_service.dart';

class CharacterAvatar extends StatefulWidget {
  final String avatar;
  final String avatarFrame;
  final String avatarBackground;
  final LoadController controller;
  const CharacterAvatar({
    super.key,
    required this.avatar,
    required this.avatarFrame,
    required this.avatarBackground,
    required this.controller,
  });

  @override
  State<StatefulWidget> createState() {
    return CharacterAvatarState();
  }
}

class CharacterAvatarState extends State<CharacterAvatar> {
  final http = HTTPService();

  Future<File> loadAvatar() {
    final queue = initQueue(AzurlaneConstants.name);
    return queue.add<File>(() async {
      final reload = widget.controller.reload;
      return http.download(widget.avatar, reload: reload);
    });
  }

  @override
  Widget build(BuildContext context) {
    const double width = 120;
    const double height = 165;
    const loadingAnimation = SizedBox(
      width: width,
      height: height,
      child: Center(
        child: LoadingAnimation(),
      ),
    );
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        if (widget.controller.load) {
          return DecoratedBox(
            position: DecorationPosition.foreground,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(widget.avatarFrame),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: DecoratedBox(
                position: DecorationPosition.background,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(widget.avatarBackground),
                  ),
                ),
                child: FutureBuilder(
                  future: loadAvatar(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return loadingAnimation;
                    }
                    if (snapshot.hasData) {
                      widget.controller.reload = false;
                      return Image.file(
                        snapshot.data!,
                        width: width,
                        height: height,
                        fit: BoxFit.fitWidth,
                      );
                    } else if (snapshot.hasError) {
                      return const BrokenImage(width: width, height: height);
                    } else {
                      return loadingAnimation;
                    }
                  },
                ),
              ),
            ),
          );
        } else {
          return loadingAnimation;
        }
      },
    );
  }
}
