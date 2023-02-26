import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/pages/azurlane/character_list.dart';

class AzurlanePage extends StatefulWidget {
  const AzurlanePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return AzurlanePageState();
  }
}

class AzurlanePageState extends State<AzurlanePage> {
  @override
  Widget build(BuildContext context) {
    return const CharacterList();
  }
}
