import 'dart:ui';

enum GunRank {
  rank1(value: 1, color: Color(0xFF666666)),
  rank2(value: 2, color: Color(0xFFA2A2A2)),
  rank3(value: 3, color: Color(0xFF5DD9C3)),
  rank4(value: 4, color: Color(0xFFD6E35A)),
  rank5(value: 5, color: Color(0xFFFDA809));

  final int value;
  final Color color;

  const GunRank({
    required this.value,
    required this.color,
  });
}
