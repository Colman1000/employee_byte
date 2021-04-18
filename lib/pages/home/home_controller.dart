import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/models/employee.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';

class HomeController extends GetxController {
  HomeController(this.db);

  final DB db;

  final employees = <int, Employee>{}.obs;
  final initializingEmployeeList = true.obs;

  Future addEmployee(Employee employee) async {
    final store = intMapStoreFactory.store('employees');

    final db = Get.find<DB>();

    final id = await store.add(db.instance!, employee.toMap());

    final _allEmployees = employees.value;
    employees.value = {
      ..._allEmployees,
      ...{id: employee}
    };
  }

  @override
  Future onInit() async {
    super.onInit();
    initializingEmployeeList.value = true;
    try {
      final store = intMapStoreFactory.store('employees');

      final db = Get.find<DB>();

      final records = await store.find(db.instance!);

      employees.value = await compute(prepEmployees, records);
    } catch (e) {
      Helpers.showSnackBar(
        'An unexpected error occurred',
        type: SnackBarType.error,
      );
    } finally {
      initializingEmployeeList.value = false;
    }
  }
}

Map<int, Employee> prepEmployees(
    List<RecordSnapshot<int, Map<String, Object?>>> records) {
  final Map<int, Employee> ret = {
    for (final rec in records) rec.key: Employee.fromMap(rec.value)
  };

  return ret;
}
