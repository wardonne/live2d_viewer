import 'package:flutter/widgets.dart';
import 'package:live2d_viewer/constants/resources.dart';

class CharacterStar extends StatelessWidget {
  final int rank;

  const CharacterStar({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.filled(
        rank,
        Image.asset(
          ResourceConstants.girlFrontlineStar,
          height: 25,
        ),
      ),
    );
  }
}
