import 'package:live2d_viewer/constants/constants.dart';

enum ShipRarity {
  rarity2(
    value: 2,
    avatarFrame: ResourceConstants.iconFrame2,
    avatarBackground: ResourceConstants.iconbg2,
  ),
  rarity3(
    value: 3,
    avatarFrame: ResourceConstants.iconFrame3,
    avatarBackground: ResourceConstants.iconbg3,
  ),
  rarity4(
    value: 4,
    avatarFrame: ResourceConstants.iconFrame4,
    avatarBackground: ResourceConstants.iconbg4,
  ),
  rarity5(
    value: 5,
    avatarFrame: ResourceConstants.iconFrame5,
    avatarBackground: ResourceConstants.iconbg5,
  ),
  rarity6(
    value: 6,
    avatarFrame: ResourceConstants.iconFrame6,
    avatarBackground: ResourceConstants.iconbg6,
  ),
  rarity7(
    value: 7,
    avatarFrame: ResourceConstants.iconFrame7,
    avatarBackground: ResourceConstants.iconbg7,
  ),
  rarity8(
    value: 8,
    avatarFrame: ResourceConstants.iconFrame8,
    avatarBackground: ResourceConstants.iconbg8,
  ),
  rarity14(
    value: 14,
    avatarFrame: ResourceConstants.iconFrame14,
    avatarBackground: ResourceConstants.iconbg14,
  ),
  rarity15(
    value: 15,
    avatarFrame: ResourceConstants.iconFrame15,
    avatarBackground: ResourceConstants.iconbg15,
  );

  final int value;
  final String avatarFrame;
  final String avatarBackground;

  const ShipRarity({
    required this.value,
    required this.avatarFrame,
    required this.avatarBackground,
  });
}

extension ShipRarityCompare on ShipRarity {
  int compareTo(ShipRarity shipRarity) {
    return value.compareTo(shipRarity.value);
  }
}
