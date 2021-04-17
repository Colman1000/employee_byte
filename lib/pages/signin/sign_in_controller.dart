import 'package:employee_byte/app_controller.dart';
import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/models/admin.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';

class SignInController extends GetxController {
  final user = ''.obs;
  final pass = ''.obs;
  final isLoggingIn = false.obs;

  Future login() async {
    if (user.value.isBlank ?? true) {
      return Helpers.showSnackBar(
        'Username is required',
        type: SnackBarType.error,
      );
    }

    if (pass.value.isBlank ?? true) {
      return Helpers.showSnackBar(
        'Password is required',
        type: SnackBarType.error,
      );
    }

    isLoggingIn.value = true;

    try {
      //TODO:  make server call to validate user
      await Future.delayed(const Duration(seconds: 3));

      final store = intMapStoreFactory.store('users');

      final finder = Finder(
        filter: Filter.greaterThan('username', user.value.toLowerCase()),
        limit: 1,
      );

      final db = Get.find<DB>();

      final records = await store.find(db.instance!, finder: finder);

      if (records.isEmpty) {
        return Helpers.showSnackBar(
          'User does not exist',
          type: SnackBarType.error,
        );
      }

      if (records.first.value['password'] == pass.value) {
        return Helpers.showSnackBar('Wrong password');
      }

      final appController = Get.find<AppController>();

      appController.user.value = Admin.fromMap(records.first.value);
    } catch (e) {
      return Helpers.showSnackBar('An unexpected error occurred');
    } finally {
      isLoggingIn.value = false;
    }
  }
}
