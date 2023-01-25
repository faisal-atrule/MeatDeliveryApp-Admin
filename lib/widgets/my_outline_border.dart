import 'package:flutter/material.dart';

import '../resources/color_res.dart';

OutlineInputBorder myOutlineBorder({required bool error}){
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
      width: 0.5,
      color: error ? ColorRes.crimsonColor : ColorRes.primaryColor,
    ),
  );
}