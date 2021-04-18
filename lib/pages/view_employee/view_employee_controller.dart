import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/pages/home/home_controller.dart';
import 'package:get/get.dart';

class ViewEmployeeController extends GetxController {
  final isDeletingEmployee = false.obs;

  Future deleteEmployee(int id) async {
    // removeEmployee
    isDeletingEmployee.value = true;

    try {
      await Get.find<HomeController>().removeEmployee(id);
      Get.back();
    } catch (e) {
      return Helpers.showSnackBar(
        'An error occurred while deleting Employee',
        type: SnackBarType.error,
      );
    } finally {
      isDeletingEmployee.value = false;
    }
  }
}
