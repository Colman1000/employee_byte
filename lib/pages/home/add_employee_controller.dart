import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/models/country.dart';
import 'package:employee_byte/models/employee.dart';
import 'package:employee_byte/pages/home/home_controller.dart';
import 'package:get/get.dart';

class AddEmployeeController extends GetxController {
  final firstName = ''.obs;
  final lastName = ''.obs;
  final gender = ''.obs;
  final designation = ''.obs;
  final dateOfBirth = Rx<DateTime?>(null);
  final passport = ''.obs;
  final address = ''.obs;
  final country = ''.obs;
  final state = ''.obs;

  //For ui update only
  final uiState = ''.obs; //used for updating ui when a state is selected
  final uiStates = <State>[].obs;

  final _step = 0.obs;

  Future _saveEmployee() async {
    final _employee = Employee(
      firstname: firstName.value,
      lastname: lastName.value,
      dateOfBirth: dateOfBirth.value!,
      gender: gender.value,
      country: country.value,
      state: state.value,
      address: address.value,
      passportPhoto: passport.value,
      designation: designation.value,
    );

    await Get.find<HomeController>().addEmployee(_employee);
    Get.back();
  }

  void next(int maxSteps) {
    if (_step.value == 0) {
      final _isValidDate = dateOfBirth.value != null &&
          (dateOfBirth.value!).isBefore(DateTime.now().subtract(1.days));

      final _isValid = firstName.value.isNotEmpty &&
          lastName.value.isNotEmpty &&
          gender.value.isNotEmpty &&
          _isValidDate;

      if (!_isValid) {
        return Helpers.showSnackBar(
          'All fields are required',
          type: SnackBarType.error,
        );
      }
    }
    if (_step.value == 1) {
      final _isValid = address.value.isNotEmpty &&
          country.value.isNotEmpty &&
          state.value.isNotEmpty;

      if (!_isValid) {
        return Helpers.showSnackBar(
          'All fields are required',
          type: SnackBarType.error,
        );
      }

      _saveEmployee();
    }

    if (_step.value >= maxSteps) {
      return;
    }
    _step.value++;
  }

  void back() {
    if (_step.value <= 0) {
      return;
    }
    _step.value--;
  }

  int get step => _step.value;
}
