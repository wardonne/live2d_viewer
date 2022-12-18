import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

T watchProvider<T>(BuildContext context, {bool listen = true}) {
  return Provider.of<T>(context, listen: listen);
}
