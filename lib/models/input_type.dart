import 'package:flutter/material.dart';

class InputType<T> {
  InputType({
    this.key,
    this.val,
    this.onChanged,
    this.obscuringCharacter = '○',
    this.decoration,
    this.obscure = false,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.keyboardType,
    this.custom,
    this.suffixIcon,
  })  : assert(onChanged != null || custom != null),
        assert(decoration != null || custom != null);

  final String? key;
  final T? val;
  final String obscuringCharacter;
  final bool obscure;
  final Function(String v)? onChanged;
  final AutovalidateMode autoValidateMode;
  final InputDecoration? decoration;
  final String? Function(String? v)? validator;
  final TextInputType? keyboardType;
  final Widget? custom;
  final Widget? suffixIcon;
}
