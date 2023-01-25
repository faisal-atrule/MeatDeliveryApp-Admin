import 'package:flutter/material.dart';

import '../resources/color_res.dart';
import 'my_outline_border.dart';

InputDecoration myInputDecoration({
  required BuildContext context,
  required String label,
  required String hint,
  bool? dense,
  bool? hasMaxLength,
  EdgeInsetsGeometry? contentPadding
}) {
  return InputDecoration(
    focusedBorder: myOutlineBorder(error: false),
    errorBorder: myOutlineBorder(error: true),
    focusedErrorBorder: myOutlineBorder(error: false),
    enabledBorder: myOutlineBorder(error: false),
    disabledBorder: myOutlineBorder(error: false),
    border: myOutlineBorder(error: false),
    isDense: dense,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
    labelText: label,
    labelStyle: Theme.of(context).textTheme.displayMedium,
    alignLabelWithHint: true,
    hintText: hint,
    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
        color: ColorRes.primaryLightColor
    ),
    counterStyle: Theme.of(context).textTheme.bodyLarge,
    counter: (hasMaxLength ?? false) ? null : const Offstage(),
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );
}