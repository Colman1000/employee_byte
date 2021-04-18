import 'package:animations/animations.dart';
import 'package:employee_byte/app_controller.dart';
import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/globals/theme.dart';
import 'package:employee_byte/pages/auth/auth_controller.dart';
import 'package:employee_byte/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/auth/auth.dart';
import 'pages/home/home_controller.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      title: 'Employee Byte',
      onInit: () async {
        //Initialize Controllers
        Get.put<AppController>(AppController(), permanent: true);
        Get.put<AuthController>(AuthController(), permanent: true);
        final db = await Get.putAsync<DB>(
          () async {
            final _db = DB();
            await _db.init();
            return _db;
          },
          permanent: true,
        );
        //TODO: improve this. [HomeController] should not totally depend on [DB]
        Get.put<HomeController>(HomeController(db), permanent: true);
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
