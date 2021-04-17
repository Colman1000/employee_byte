import 'package:animations/animations.dart';
import 'package:employee_byte/app_controller.dart';
import 'package:employee_byte/globals/theme.dart';
import 'package:employee_byte/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/auth/auth.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      title: 'Employee Byte',
      onInit: () {
        //Initialize Controllers

        Get.put(AppController(), permanent: true);
      },
      home: Obx(
        () {
          final user = Get.find<AppController>().user.value;

          return PageTransitionSwitcher(
            duration: const Duration(milliseconds: 250),
            reverse: user == null,
            transitionBuilder: (
              child,
              animation,
              secondaryAnimation,
            ) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.scaled,
                child: child,
              );
            },
            child: user == null ? Auth() : Home(),
          );
        },
      ),
    );
  }
}
