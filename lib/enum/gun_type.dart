import 'package:live2d_viewer/constants/constants.dart';

enum GunType {
  hg(value: 1, label: 'HG', icons: <int, String>{
    1: ResourceConstants.hgIcon2,
    2: ResourceConstants.hgIcon2,
    3: ResourceConstants.hgIcon3,
    4: ResourceConstants.hgIcon4,
    5: ResourceConstants.hgIcon5,
  }),
  smg(value: 2, label: 'SMG', icons: <int, String>{
    1: ResourceConstants.smgIcon2,
    2: ResourceConstants.smgIcon2,
    3: ResourceConstants.smgIcon3,
    4: ResourceConstants.smgIcon4,
    5: ResourceConstants.smgIcon5,
  }),
  rf(value: 3, label: 'RF', icons: <int, String>{
    1: ResourceConstants.rfIcon2,
    2: ResourceConstants.rfIcon2,
    3: ResourceConstants.rfIcon3,
    4: ResourceConstants.rfIcon4,
    5: ResourceConstants.rfIcon5,
  }),
  ar(value: 4, label: 'AR', icons: <int, String>{
    1: ResourceConstants.arIcon2,
    2: ResourceConstants.arIcon2,
    3: ResourceConstants.arIcon3,
    4: ResourceConstants.arIcon4,
    5: ResourceConstants.arIcon5,
  }),
  mg(value: 5, label: 'MG', icons: <int, String>{
    1: ResourceConstants.mgIcon2,
    2: ResourceConstants.mgIcon2,
    3: ResourceConstants.mgIcon3,
    4: ResourceConstants.mgIcon4,
    5: ResourceConstants.mgIcon5,
  }),
  sg(value: 6, label: 'SG', icons: <int, String>{
    1: ResourceConstants.sgIcon2,
    2: ResourceConstants.sgIcon2,
    3: ResourceConstants.sgIcon3,
    4: ResourceConstants.sgIcon4,
    5: ResourceConstants.sgIcon5,
  });

  final int value;
  final String label;
  final Map<int, String> icons;

  const GunType({
    required this.value,
    required this.label,
    required this.icons,
  });
}
