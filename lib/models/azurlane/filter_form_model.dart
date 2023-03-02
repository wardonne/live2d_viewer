import 'package:live2d_viewer/models/base_model.dart';

class FilterFormModel extends BaseModel {
  String name;
  List<int> type;
  List<int> rarity;
  List<int> nationality;
  FilterFormModel({
    required this.name,
    required this.type,
    required this.rarity,
    required this.nationality,
  });

  FilterFormModel.init()
      : name = '',
        type = [],
        rarity = [],
        nationality = [];

  FilterFormModel.from(FilterFormModel model)
      : name = model.name,
        type = model.type,
        rarity = model.rarity,
        nationality = model.nationality;

  void reset() {
    name = '';
    type = [];
    rarity = [];
    nationality = [];
  }

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
