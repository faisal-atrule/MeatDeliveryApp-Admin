import 'package:flutter/material.dart';

import '../resources/color_res.dart';

Widget bottomSheetDecoration({
  required BuildContext context,
  required Widget child
}){
  return Container(
    padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: 20 + MediaQuery.of(context).viewInsets.bottom
    ),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
        ),
        color: ColorRes.whiteColor
    ),
    child: child,
  );
}