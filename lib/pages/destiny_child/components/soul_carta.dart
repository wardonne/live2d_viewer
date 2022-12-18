import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:live2d_viewer/constant/resources.dart';
import 'package:live2d_viewer/models/soul_carta.dart';
import 'package:live2d_viewer/widget/preview_windows/preview_window.dart';

import 'soul_carta_item.dart';

class SoulCartaTabView extends StatelessWidget {
  final PreviewWindowController controller;
  const SoulCartaTabView({super.key, required this.controller});

  Future<List<SoulCarta>> loadData() async {
    var content = await rootBundle.loadString(dcSoulCartaDataPath);
    var list = jsonDecode(content.toString());
    return loadSoulCarta(list);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
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
          return const Center(child: Text('暂无数据'));
        }
      },
    );
  }

  _soulCartaList(List<SoulCarta>? data) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
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
