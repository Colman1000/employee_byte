import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/models/admin.dart';
import 'package:employee_byte/models/country.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';

import '../../app_controller.dart';

class SignUpController extends GetxController {
  final firstName = ''.obs;
  final lastName = ''.obs;
  final gender = ''.obs;
  final dateOfBirth = Rx<DateTime?>(null);
  final passport = ''.obs; //TODO: get passport image
  final address = ''.obs;
  final country = ''.obs;
  final state = ''.obs;
  final username = ''.obs;
  final password = ''.obs;

  final uiState = ''.obs; //used for updating ui when a state is selected
  final uiStates = <State>[].obs;

  final _step = 0.obs;

  final showPass = false.obs;

  void togglePasswordVisibility() {
    showPass.value = !showPass.value;
  }

  Future _saveUser() async {
    //TODO: Sign user in
    final _admin = Admin(
      firstname: firstName.value,
      lastname: lastName.value,
      dateOfBirth: dateOfBirth.value!,
      gender: gender.value,
      country: country.value,
      state: state.value,
      address: address.value,
      passportPhoto: passport.value,
      password: password.value,
      username: username.value,
    );

    //TODO: Save user to DB

    //TODO: refactor stores for ease of use... eg Store.users => 'users'

    final store = intMapStoreFactory.store('users');

    final db = Get.find<DB>();

    await store.add(db.instance!, _admin.toMap());

    Get.find<AppController>().user.value = _admin;
    //UI should auto switch to main page
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
    }
    if (_step.value == 2) {
      final _isValid = username.value.isNotEmpty && password.value.isNotEmpty;

      if (!_isValid) {
        return Helpers.showSnackBar(
          'All fields are required',
          type: SnackBarType.error,
        );
      }
      _saveUser();

      return;
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
