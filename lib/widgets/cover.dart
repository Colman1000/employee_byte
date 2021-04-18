import 'package:flutter/material.dart';

class Cover extends StatelessWidget {
  const Cover({Key? key, required this.child, this.fab}) : super(key: key);
  final Widget child;
  final FloatingActionButton? fab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: child,
      ),
      floatingActionButton: fab,
    );
  }
}
