import 'package:flutter/material.dart';

import '../resources/color_res.dart';

class MyInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool? obscureText;
  final TextInputAction textInputAction;
  final bool? autofocus;
  final TextInputType keyboardType;
  final TextStyle? style;
  final int? maxLines;
  final int? maxLength;
  final Color? cursorColor;
  final InputDecoration decoration;
  final TextCapitalization? textCapitalization;
  final TextAlign? textAlign;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;

  const MyInputField({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.obscureText,
    required this.textInputAction,
    this.autofocus,
    required this.keyboardType,
    required this.style,
    this.maxLines,
    this.maxLength,
    this.cursorColor,
    required this.decoration,
    this.textCapitalization,
    this.textAlign,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      textInputAction: textInputAction,
      autofocus: autofocus ?? false,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textAlign: textAlign ?? TextAlign.start,
      style: style,
      maxLines: maxLines ?? 1,
      maxLength: maxLength ?? TextField.noMaxLength,
      cursorColor: cursorColor ?? ColorRes.primaryColor,
      decoration: decoration,
      validator: validator ?? (validatorValue) {
        return null;
      },
      onSaved: onSaved ?? (value) {},
      onChanged: onChanged ?? (value) {},
      onFieldSubmitted: onFieldSubmitted ?? (submittedValue) {},
      onTap: onTap ?? () {}
    );
  }
}