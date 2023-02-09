import 'package:live2d_viewer/constants/constants.dart';
import 'package:live2d_viewer/models/base_model.dart';
import 'package:live2d_viewer/models/girl_frontline/skin_model.dart';

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
      '${GirlFrontlineConstants.characterSpineURL}/${skin.code}';

  String get skelURL => '${GirlFrontlineConstants.characterSpineURL}/$skel';

  String get atlasURL => '${GirlFrontlineConstants.characterSpineURL}/$atlas';
}
