import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/models/employee.dart';
import 'package:employee_byte/pages/view_employee/view_employee.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sembast/sembast.dart';

class HomeController extends GetxController {
  HomeController(this.db);

  final DB db;

  final employees = <int, Employee>{}.obs;
  final initializingEmployeeList = true.obs;

  Future<void> addEmployee(Employee employee) async {
    final store = intMapStoreFactory.store('employees');

    final db = Get.find<DB>();

    final id = await store.add(db.instance!, employee.toMap());

    final _allEmployees = employees.value;
    employees.value = {
      ..._allEmployees,
      ...{id: employee}
    };
  }

  Future<void> removeEmployee(int key) async {
    final store = intMapStoreFactory.store('employees');

    final db = Get.find<DB>();

    await store.record(key).delete(db.instance!);

    final _allEmployees = employees.value..remove(key);
    employees.value = {
      ..._allEmployees,
    };
  }

  Future<void> findEmployee(BuildContext context) async {
    final _employee = await showSearch(
      context: context,
      delegate: EmployeeSearchDelegate<Map<int, Employee>?>(),
    ) as Map<int, Employee>?;

    if (_employee == null) return;

    viewEmployee(employee: _employee.values.first, id: _employee.keys.first);
  }

  void viewEmployee({required Employee employee, required int id}) {
    Get.to(
      () => ViewEmployee(id: id, employee: employee),
      fullscreenDialog: true,
      preventDuplicates: false,
      curve: Curves.decelerate,
      duration: 200.milliseconds,
      transition: Transition.rightToLeftWithFade,
      popGesture: true,
    );
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
