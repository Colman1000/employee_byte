import 'package:employee_byte/globals/theme.dart';
import 'package:flutter/material.dart';

class EmptyListPlaceholder extends StatelessWidget {
  const EmptyListPlaceholder({
    this.tag = 'Your cart is empty!',
    this.instruction = 'Browse for products and add them to cart',
    this.showInstruction = true,
    this.animate = false,
    this.icon = Icons.opacity,
  });

  final String tag;
  final String instruction;
  final bool showInstruction;
  final bool animate;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final Widget _iconWidget = Icon(
      icon,
      size: 40,
      color: AppTheme.primaryColorL.withOpacity(0.55),
    );

    final _children = [
      TweenAnimationBuilder(
        duration: const Duration(milliseconds: 150),
        tween: Tween<double>(begin: 0.5, end: 1),
        builder: (BuildContext context, double anim, Widget? child) {
          return Transform.scale(
            scale: anim,
            child: Opacity(
              opacity: anim,
              child: child,
            ),
          );
        },
        child: _iconWidget,
      ),
      const SizedBox(height: 10),
      Text(
        tag.toUpperCase(),
        style: const TextStyle()
            .copyWith(color: Colors.grey.shade500, fontSize: 25),
      ),
      const SizedBox(height: 10),
      if (showInstruction) ...[
        Text(
          instruction,
          style: const TextStyle().copyWith(
            color: AppTheme.primaryColorD,
          ),
        ),
        const SizedBox(height: 20),
      ]
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(mainAxisSize: MainAxisSize.min, children: _children),
      ),
    );
  }
}
