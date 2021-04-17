import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/globals/theme.dart';
import 'package:employee_byte/pages/auth/auth_controller.dart';
import 'package:employee_byte/pages/signin/sign_in_controller.dart';
import 'package:employee_byte/widgets/button.dart';
import 'package:employee_byte/widgets/cover.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  final _signInController = SignInController();

  @override
  Widget build(BuildContext context) {
    final _authController = Get.find<AuthController>();
    final _children = [
      const SizedBox(
        height: 60,
      ),
      Align(
        child: Text(
          'Sign As Admin',
          style: Get.textTheme.headline4,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Align(
        child: Text(
          'Enter your email and password to continue',
          style: Get.textTheme.subtitle1,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      TextFormField(
        decoration: AppTheme.inputDecor(
          Icon(Icons.person_outline_rounded),
          'Username',
        ),
        validator: Validators.required(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (v) => _signInController.user.value = v.trim(),
      ),
      const SizedBox(
        height: 30,
      ),
      TextFormField(
        decoration: AppTheme.inputDecor(
          Icon(Icons.lock_outline),
          'Password',
        ),
        validator: Validators.required(),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (v) => _signInController.pass.value = v.trim(),
        obscureText: true,
        obscuringCharacter: '○',
      ),
      const SizedBox(
        height: 30,
      ),
      Obx(
        () => Button(
          label: 'HELLO',
          onPressed: _signInController.login,
          loading: _signInController.isLoggingIn.value,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
    ];

    return Cover(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => _children[index],
                itemCount: _children.length,
              ),
            ),
            TextButton(
              onPressed: () {
                _authController.goTo(AuthPage.signUp);
              },
              child: Text('SIGN IN'),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
