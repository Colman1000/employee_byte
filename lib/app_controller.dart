import 'package:get/get.dart';

import 'models/admin.dart';

class AppController extends GetxController {
  final user = Rx<Admin?>(null);

  void logout() {
    user.value = null;
  }
}
