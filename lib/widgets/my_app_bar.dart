import 'package:flutter/material.dart';

PreferredSizeWidget myAppBar({
  required String title,
  required bool centerTitle,
  required Color backgroundColor,
  required bool isLeadingIcon,
  required IconData icon,
  required Function() onPressed,
  required List<Widget> list,
  PreferredSizeWidget? bottom
}){
  return AppBar(
    elevation: 0,
    centerTitle: centerTitle,
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: isLeadingIcon,
    titleSpacing: 0,
    title: Text(title),
    leading: isLeadingIcon ? IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
    ) : null,
    actions: list,
    bottom: bottom,
  );
}