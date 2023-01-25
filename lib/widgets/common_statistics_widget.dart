import 'package:flutter/material.dart';

import '../resources/color_res.dart';

Widget commonStatisticsWidget({
  required BuildContext context,
  required String value,
  required String heading,
  required Color backgroundColor,
  required bool isLoading,
  required Function()? onTap
}){
  return Expanded(
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          color: ColorRes.darkGreyColor.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 0),
        )],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                isLoading ?
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(ColorRes.whiteColor),
                  ),
                ) :
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(color: ColorRes.whiteColor),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Text(
                      heading,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorRes.whiteColor),
                    )),
                  ],
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(vertical: 5),
              color: ColorRes.darkGreyColor.withOpacity(0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Text("More info", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: ColorRes.whiteColor),)),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.arrow_right_rounded,
                    size: 24,
                    color: ColorRes.whiteColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}