/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

import 'package:flutter/widgets.dart';

class $AssetsLangGen {
  const $AssetsLangGen();

  String get am => 'assets/lang/am.json';
  String get en => 'assets/lang/en.json';
  String get ru => 'assets/lang/ru.json';
}

class Assets {
  Assets._();

  static const String countryCodes = 'assets/country-codes.json';
  static const $AssetsLangGen lang = $AssetsLangGen();
  static const AssetGenImage logo = AssetGenImage('assets/logo.png');
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    bool excludeFromSemantics = false,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      image: this,
      excludeFromSemantics: excludeFromSemantics,
      alignment: alignment,
      repeat: repeat,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}
