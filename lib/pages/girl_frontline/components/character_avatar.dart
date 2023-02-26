import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/global_components.dart';
import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/controllers/hover_controller.dart';
import 'package:live2d_viewer/controllers/load_controller.dart';
import 'package:live2d_viewer/queue/queue.dart';
import 'package:live2d_viewer/services/http_service.dart';

class CharacterAvatar extends StatefulWidget {
  final String avatar;
  final String hoverAvatar;
  final LoadController controller;
  final HoverController hoverController;
  const CharacterAvatar({
    super.key,
    required this.avatar,
    required this.hoverAvatar,
    required this.controller,
    required this.hoverController,
  });

  @override
  State<StatefulWidget> createState() {
    return CharacterAvatarState();
  }
}

class CharacterAvatarState extends State<CharacterAvatar> {
  final HTTPService http = HTTPService();

  @override
  initState() {
    super.initState();
  }

  Future<List<File>> _downloadAvatars() async {
    final reload = widget.controller.reload;
    final image = await http.download(
      widget.avatar,
      reload: reload,
    );
    final hoverImage = await http.download(
      widget.hoverAvatar,
      reload: reload,
    );
    if (reload) {
      await FileImage(image).evict();
      await FileImage(hoverImage).evict();
    }
    return [
      image,
      hoverImage,
    ];
  }

  @override
  Widget build(BuildContext context) {
    const double width = 170;
    const double height = 300;
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image:
                    AssetImage(ResourceConstants.girlFrontlineCharacterFrame),
              ),
            ),
            position: DecorationPosition.foreground,
            child: FutureBuilder(
              future: () {
                final queue = initQueue(GirlFrontlineConstants.name);
                return queue.add<List<File>>(_downloadAvatars);
              }(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return loadingAnimation;
                }
                if (snapshot.hasData) {
                  widget.controller.reload = false;
                  return AnimatedBuilder(
                      animation: widget.hoverController,
                      builder: (context, _) {
                        return Image.file(
                          widget.hoverController.value
                              ? snapshot.data![1]
                              : snapshot.data![0],
                          width: width,
                          height: height,
                        );
                      });
                } else if (snapshot.hasError) {
                  return const BrokenImage(width: width, height: height);
                } else {
                  return loadingAnimation;
                }
              },
            ),
          );
        } else {
          return loadingAnimation;
        }
      },
    );
  }
}
