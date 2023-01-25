import 'dart:typed_data';

import 'package:flutter/material.dart';

Widget myAssetImage({
  required String imagePath,
  double? width, height,
  BoxFit? fit
}){
  return Image.asset(
    imagePath,
    width: width?.toDouble(),
    height: height?.toDouble(),
    fit: fit ?? BoxFit.contain,
  );
}

Widget myMemoryImage({
  required Uint8List imagePath,
  double? width, height,
  BoxFit? fit
}){
  return Image.memory(
    imagePath,
    width: width?.toDouble(),
    height: height?.toDouble(),
    fit: fit ?? BoxFit.contain,
  );
}