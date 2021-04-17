import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  const Cover({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
    );
  }
}
