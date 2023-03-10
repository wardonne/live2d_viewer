import 'package:live2d_viewer/models/base_model.dart';

class FilterFormModel extends BaseModel {
  String name;
  FilterFormModel({required this.name});

  FilterFormModel.init() : this(name: '');

  FilterFormModel.from(FilterFormModel model) : this(name: model.name);

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
