import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.label,
    this.onPressed,
    this.loading = false,
    this.disabled = false,
  }) : super(key: key);

  final String label;
  final bool loading, disabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final bool _disabled = disabled || loading || (onPressed == null);

    final _child = loading
        ? const Center(
            child: CupertinoActivityIndicator(),
          )
        : Text(label);

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.disabled) || _disabled
                ? Colors.transparent
                : null;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.disabled) || _disabled
                ? Get.theme.disabledColor
                : Colors.white;
          },
        ),
        elevation: MaterialStateProperty.resolveWith(
          (states) {
            return states.contains(MaterialState.disabled) || _disabled
                ? 0
                : null;
          },
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
        ),
        enableFeedback: true,
      ),
      onPressed: _disabled ? null : onPressed,
      child: _child,
    );
  }
}
