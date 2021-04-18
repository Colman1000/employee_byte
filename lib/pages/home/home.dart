import 'package:employee_byte/app_controller.dart';
import 'package:employee_byte/globals/theme.dart';
import 'package:employee_byte/pages/home/home_controller.dart';
import 'package:employee_byte/widgets/cover.dart';
import 'package:employee_byte/widgets/empty_list_placeholder.dart';
import 'package:employee_byte/widgets/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _homeController = Get.find<HomeController>();

    return Cover(
      fab: FloatingActionButton(
        onPressed: () {},
        foregroundColor: Colors.white,
        backgroundColor: AppTheme.primaryColorD,
        child: const Icon(Icons.add),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(
            title: const HeaderLeadingWidget(title: 'All Employees'),
            action: PopupMenuButton(
              itemBuilder: (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  value: 'about',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.info_outline_rounded,
                        size: Get.textTheme.subtitle1?.fontSize ?? 14,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'About',
                        style: Get.textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'darkMode',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.brightness_medium_outlined,
                        // Icons.nights_stay_outlined,
                        size: Get.textTheme.subtitle1?.fontSize ?? 14,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Toggle Dark Mode',
                        style: Get.textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                PopupMenuItem(
                  value: 'logout',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.power_settings_new,
                        size: Get.textTheme.subtitle1?.fontSize ?? 14,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        'Logout',
                        style: Get.textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
              icon: const Icon(Icons.more_vert),
              onSelected: (v) async {
                if (v == 'about') {
                  showAboutDialog(
                    context: context,
                    children: [
                      const Align(
                        child: Text('Reach out to us anytime'),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        child: SelectableText(
                          '+234 806 311 3147',
                          onTap: () async {
                            const _tel = 'tel:+2348063113147';
                            if (await canLaunch(_tel)) {
                              launch(_tel);
                            }
                          },
                          style: const TextStyle().copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text('Made with '),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 15,
                          ),
                          Text(' Colman1000'),
                        ],
                      )
                    ],
                    applicationVersion: '1.0.0',
                    applicationIcon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Get.theme.primaryColor.withOpacity(0.03),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: const SizedBox(
                        height: 25,
                        width: 25,
                        child: FlutterLogo(
                          size: 25,
                        ),
                      ),
                    ),
                  );
                }
                if (v == 'darkMode') {
                  Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                  );

                  final isDarkMode = Get.isDarkMode;

                  /*Get.find<AppController>().isDarkThemeMode(isDarkMode);

                    unawaited(GetStorage().write(
                      QwikSharedPreferences.userDarkModePreference,
                      Get.isDarkMode ? 'l' : 'd',
                    ));*/
                  Get.forceAppUpdate();
                }
                if (v == 'logout') {
                  Get.find<AppController>().logout();
                }
              },
            ),
          ),
          if (_homeController.employees.isEmpty) ...[
            const EmptyListPlaceholder(
              tag: 'You Have No Employees Yet',
              instruction: 'Tap + To Add Employees',
              icon: Icons.people_outline_rounded,
            )
          ]
        ],
      ),
    );
  }
}
