import 'package:flutter/foundation.dart';

const appIcon = 'assets/application/app_icon.ico';
const appSettings = 'assets/application/settings.json';

const dcAssetsPath = 'assets/destiny_child';
const dcSoulCartaAssetsPath = '$dcAssetsPath/soul_carta';
const dcSoulCartaDataPath = '$dcSoulCartaAssetsPath/data.json';
var dcSoulCartaImagePath = (kDebugMode
    ? '$dcSoulCartaAssetsPath/images'
    : 'data/flutter_assets/$dcSoulCartaAssetsPath/images');
const dcSoulCartaAvatarPath = kDebugMode
    ? '$dcSoulCartaAssetsPath/avatars'
    : 'data/flutter_assets/$dcSoulCartaAssetsPath/avatars';
