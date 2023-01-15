import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LocaleProvider with ChangeNotifier, DiagnosticableTreeMixin {
  Locale locale;

  LocaleProvider(this.locale);

  void changeLocale(Locale locale) {
    if (this.locale != locale) {
      this.locale = locale;
      notifyListeners();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('locale', locale));
  }
}
