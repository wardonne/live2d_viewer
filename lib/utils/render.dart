import 'package:flutter/services.dart';

Future<String> render(String view, {Map<String, String>? data}) async {
  var content = await rootBundle.loadString(view);
  if (data != null) {
    data.forEach((key, value) {
      content = content.replaceAll('\${$key}', value);
    });
  }
  return content;
}
