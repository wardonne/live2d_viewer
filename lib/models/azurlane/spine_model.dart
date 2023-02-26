import 'package:live2d_viewer/constants/azurlane.dart';
import 'package:live2d_viewer/models/azurlane/models.dart';
import 'package:live2d_viewer/models/base_model.dart';

class SpineModel extends BaseModel {
  final String skel;
  final String atlas;

  late final SkinModel skin;

  SpineModel({
    required this.skel,
    required this.atlas,
    required this.skin,
  });

  SpineModel.fromJson(Map<String, dynamic> json)
      : skel = json['skel'] as String,
        atlas = json['atlas'] as String;

  @override
  Map<String, dynamic> toJson() {
    return {
      'skel': skel,
      'atlas': atlas,
    };
  }

  String get resourceURL =>
      '${AzurlaneConstants.characterSpineURL}/${skin.code}';

  String get skelURL => '${AzurlaneConstants.characterSpineURL}/$skel';

  String get atlasURL => '${AzurlaneConstants.characterSpineURL}/$atlas';
}
