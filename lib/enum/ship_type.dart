enum ShipType {
  type1(value: 1, label: '驱逐'),
  type2(value: 2, label: '轻巡'),
  type3(value: 3, label: '重巡'),
  type18(value: 18, label: '超巡'),
  type4(value: 4, label: '战巡'),
  type5(value: 5, label: '战列'),
  type6(value: 6, label: '轻航'),
  type7(value: 7, label: '航母'),
  type8(value: 8, label: '潜艇'),
  type10(value: 10, label: '航战'),
  type12(value: 12, label: '维修'),
  type13(value: 13, label: '重炮'),
  type19(value: 19, label: '运输'),
  type22(value: 22, label: '风帆');

  final int value;
  final String label;

  const ShipType({
    required this.value,
    required this.label,
  });
}

extension ShipTypeCompare on ShipType {
  int compareTo(ShipType shipType) {
    return value.compareTo(shipType.value);
  }
}
