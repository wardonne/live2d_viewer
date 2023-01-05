import 'package:live2d_viewer/constants/application.dart';

class ApplicationSettings extends Object {
  String? defaultSidebar;

  ApplicationSettings({this.defaultSidebar});

  ApplicationSettings.init()
      : defaultSidebar = ApplicationConstants.defaultSidebar;

  ApplicationSettings.fromJson(Map<String, dynamic>? json)
      : defaultSidebar =
            json?['default_sidebar'] ?? ApplicationConstants.defaultSidebar;

  Map<String, dynamic> toJson() => {
        'default_sidebar': defaultSidebar,
      };

  @override
  String toString() => toJson().toString();
}
