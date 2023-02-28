import 'package:live2d_viewer/models/base_model.dart';

class FilterFormModel extends BaseModel {
  String? name;
  int? type;
  int? rarity;
  int? nationality;
  FilterFormModel({
    this.name,
    this.type,
    this.rarity,
    this.nationality,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'rarity': rarity,
      'nationality': nationality,
    };
  }
}
