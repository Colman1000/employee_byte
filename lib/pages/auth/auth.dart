import 'package:animations/animations.dart';
import 'package:employee_byte/pages/auth/auth_controller.dart';
import 'package:employee_byte/pages/signin/signin.dart';
import 'package:employee_byte/pages/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();

    return WillPopScope(
      onWillPop: () async {
        _authController.goBack();
        return false;
      },
      child: Obx(
        () => PageTransitionSwitcher(
          duration: const Duration(milliseconds: 250),
          reverse: _authController.currentPage.index <
              _authController.prevPage.index,
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
          child: _authController.currentPage == AuthPage.signIn
              ? SignIn()
              : SignUp(),
        ),
      ),
    );
  }
}
