import 'package:flutter/material.dart';

import '../resources/color_res.dart';

Widget bottomSheetBar({
  required BuildContext context
}){
  return Container(
    height: 5,
    margin: const EdgeInsets.only(bottom: 20),
    width: MediaQuery.of(context).size.width * 0.2,
    decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: ColorRes.goldColor
    ),
  );
}