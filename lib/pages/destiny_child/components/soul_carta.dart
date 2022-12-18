import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:live2d_viewer/models/soul_carta.dart';
import 'package:live2d_viewer/providers/settings_provider.dart';
import 'package:live2d_viewer/utils/watch_provider.dart';
import 'package:live2d_viewer/widget/preview_windows/preview_window.dart';

import 'soul_carta_item.dart';

class SoulCartaTabView extends StatelessWidget {
  final PreviewWindowController controller;
  const SoulCartaTabView({super.key, required this.controller});

  Future<List<SoulCarta>> loadData(BuildContext context) async {
    var soulCartaSettings = watchProvider<SettingsProvider>(context)
        .settings!
        .destinyChildSettings!
        .soulCartaSettings;
    var file = File(soulCartaSettings!.dataPath!);
    var content = await file.readAsString();
    var list = jsonDecode(content.toString());
    return loadSoulCarta(list);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: _soulCartaList(data),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return const Center(child: Text('Empty data'));
        }
      },
    );
  }

  _soulCartaList(List<SoulCarta>? data) {
    return Wrap(
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: data!.map((item) {
        return SoulCartaItem(
          data: item,
          controller: controller,
        );
      }).toList(),
    );
  }
}
