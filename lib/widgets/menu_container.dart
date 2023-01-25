import 'package:flutter/material.dart';

import '../resources/color_res.dart';

Widget menuContainer({
  required BuildContext context,
  required String menuTitle,
  double? topMargin
}){
  return Container(
    margin: EdgeInsets.only(top: topMargin?.toDouble() ?? 0),
    padding: const EdgeInsets.all(20),
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      boxShadow: [BoxShadow(
        color: ColorRes.darkGreyColor.withOpacity(0.2),
        spreadRadius: 0.3,
        blurRadius: 1,
        offset: const Offset(0, 0),
      )],
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: ColorRes.whiteColor,
    ),
    child: Row(
      children: [
        const Icon(
          Icons.adjust_rounded,
          color: ColorRes.primaryColor,
          size: 24.0,
        ),
        Expanded(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                menuTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              )
          ),
        ),
        const Icon(
          Icons.double_arrow_outlined,
          color: ColorRes.primaryColor,
          size: 24.0,
        )
      ],
    ),
  );
}