import 'package:live2d_viewer/models/azurlane/spine_painting_layer_model.dart';
import 'package:live2d_viewer/models/base_model.dart';

class SpinePaintingModel extends BaseModel {
  late final List<SpinePaintingLayerModel> layers;

  SpinePaintingModel({
    required this.layers,
  });

  SpinePaintingModel.fromJson(Map<String, dynamic> json) {
    layers = (json['layers'] as List<dynamic>)
        .map((layer) =>
            SpinePaintingLayerModel.fromJson(layer as Map<String, dynamic>))
        .toList();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'layers': layers,
    };
  }
}
