import 'package:live2d_viewer/enum/spine_painting_layer_type.dart';
import 'package:live2d_viewer/models/base_model.dart';

class SpinePaintingLayerModel extends BaseModel {
  late final SpinePaintingLayerType type;
  final String? skel;
  final String? atlas;
  final String? texture;
  late final Map<String, num>? size;
  late final Map<String, num>? offset;

  SpinePaintingLayerModel({
    required this.type,
    this.skel,
    this.atlas,
    this.texture,
    this.size,
    this.offset,
  });

  SpinePaintingLayerModel.fromJson(Map<String, dynamic> json)
      : skel = json['skel'] as String?,
        atlas = json['atlas'] as String?,
        texture = json['texture'] as String? {
    switch (json['type'] as String) {
      case 'image':
        type = SpinePaintingLayerType.image;
        break;
      case 'spine':
        type = SpinePaintingLayerType.spine;
        break;
      default:
        type = SpinePaintingLayerType.spine;
    }

    size = (json['size'] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(key, value as num));
    offset = (json['offset'] as Map<String, dynamic>?)
        ?.map((key, value) => MapEntry(key, value as num));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.value,
      if (skel != null) 'skel': skel,
      if (atlas != null) 'atlas': atlas,
      if (texture != null) 'texture': texture,
      if (size != null) 'size': size,
      if (offset != null) 'offset': offset,
    };
  }
}
