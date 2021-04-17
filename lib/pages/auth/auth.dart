import 'package:animations/animations.dart';
import 'package:employee_byte/pages/auth/auth_controller.dart';
import 'package:employee_byte/pages/signin/signin.dart';
import 'package:employee_byte/pages/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _cont = AuthController();

    return Obx(
      () => PageTransitionSwitcher(
        duration: const Duration(milliseconds: 250),
        reverse: _cont.currentPage.index > _cont.prevPage.index,
        transitionBuilder: (
          child,
          animation,
          secondaryAnimation,
        ) {
          return SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.vertical,
            child: child,
          );
        },
        child: _cont.currentPage == AuthPage.signIn ? SignIn() : SignUp(),
      ),
    );
  }
}
