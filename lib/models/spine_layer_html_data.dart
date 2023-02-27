import 'dart:convert';

class SpineLayerHtmlData extends Object {
  final List<Map<String, dynamic>> layers;

  SpineLayerHtmlData({required this.layers});

  Map<String, dynamic> toJson() => {
        'layers': layers,
      };

  @override
  String toString() => jsonEncode(toJson());
}
