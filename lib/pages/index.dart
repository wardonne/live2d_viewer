import 'package:flutter/material.dart';
import 'package:live2d_viewer/components/language_selection.dart';
import 'package:live2d_viewer/constants/games.dart';
import 'package:live2d_viewer/constants/styles.dart';
import 'package:live2d_viewer/generated/l10n.dart';
import 'package:live2d_viewer/widget/buttons/container_button.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).title),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const LanguageSelection(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: (MediaQuery.of(context).size.width - 600) / 2,
            top: (MediaQuery.of(context).size.height - 400) / 2 - 50,
            child: Container(
              height: 400,
              width: 600,
              decoration: BoxDecoration(
                color: Styles.popupBackgrounColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.white70),
              ),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white70),
                      ),
                    ),
                    child: Center(child: Text(S.of(context).indexTitle)),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Wrap(
                        spacing: 10,
                        children: Games.list
                            .map((item) => ContainerButton(
                                  width: 80,
                                  padding: const EdgeInsets.all(10),
                                  hoverBackgroundColor:
                                      Styles.hoverBackgroundColor,
                                  onClick: () =>
                                      Navigator.pushNamed(context, item.route),
                                  child: Column(
                                    children: [
                                      Center(child: Image.asset(item.icon)),
                                      const Divider(
                                          height: 5, color: Colors.transparent),
                                      Center(
                                        child: Text(
                                          S.of(context).gameTitles(item.name),
                                          overflow: TextOverflow.ellipsis,
                                          style: Styles.textStyle,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
