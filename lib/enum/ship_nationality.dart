enum ShipNationality {
  nationlity1(value: 1, label: '白鹰'),
  nationlity2(value: 2, label: '皇家'),
  nationlity3(value: 3, label: '重樱'),
  nationlity4(value: 4, label: '铁血'),
  nationlity5(value: 5, label: '东煌'),
  nationlity6(value: 6, label: '撒丁帝国'),
  nationlity7(value: 7, label: '北方联合'),
  nationlity8(value: 8, label: '自由鸢尾'),
  nationlity9(value: 9, label: '维希教廷'),
  nationlity96(value: 96, label: '飓风'),
  nationlity97(value: 97, label: 'META'),
  nationlity98(value: 98, label: '其他'),
  nationlity101(value: 101, label: '海王星'),
  nationlity102(value: 102, label: '哔哩哔哩'),
  nationlity103(value: 103, label: '传颂之物'),
  nationlity104(value: 104, label: 'KizunaAI'),
  nationlity105(value: 105, label: 'hololive'),
  nationlity106(value: 106, label: '维纳斯假期'),
  nationlity107(value: 107, label: '偶像大师'),
  nationlity108(value: 108, label: 'SSSS'),
  nationlity109(value: 109, label: 'Atelier Ryza');

  final int value;
  final String label;

  const ShipNationality({
    required this.value,
    required this.label,
  });
}
