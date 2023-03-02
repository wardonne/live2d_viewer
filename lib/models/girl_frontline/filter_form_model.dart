import 'package:live2d_viewer/models/base_model.dart';

class FilterFormModel extends BaseModel {
  String name;
  List<int> type;
  List<int> rank;

  FilterFormModel({
    required this.name,
    required this.type,
    required this.rank,
  });

  FilterFormModel.init()
      : name = '',
        type = [],
        rank = [];

  FilterFormModel.from(FilterFormModel model)
      : name = model.name,
        type = model.type,
        rank = model.rank;

  void reset() {
    name = '';
    type = [];
    rank = [];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'rank': rank,
    };
  }
}
