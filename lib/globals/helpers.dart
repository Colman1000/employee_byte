import 'package:employee_byte/models/employee.dart';
import 'package:employee_byte/pages/home/home_controller.dart';
import 'package:employee_byte/widgets/employee_display_widget.dart';
import 'package:employee_byte/widgets/empty_list_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DB {
  DB() {
    init();
  }

  final _path = 'employee_byte';
  final dbFactory = databaseFactoryIo;

  Database? instance;

  Future init() async {
    // We use the database factory to open the database
    if (instance != null) return;

    // get the application documents directory
    final dir = await getApplicationDocumentsDirectory();
    // make sure it exists
    await dir.create(recursive: true);
    // build the database path
    final dbPath = join(dir.path, _path);
    // open the database
    instance = await dbFactory.openDatabase(dbPath);
  }
}

class Validators {
  static String? Function(dynamic v) required({String? errorText}) {
    return (v) {
      final bool _isValid = v?.toString().trim().isNotEmpty ?? false;

      return _isValid ? null : (errorText ?? 'This field is required');
    };
  }
}

class Helpers {
  static void showSnackBar(
    String message, {
    SnackBarDuration duration = SnackBarDuration.quick,
    SnackBarType type = SnackBarType.log,
    void Function(GetBar<Object>)? onTap,
    bool vibrate = false,
  }) {
    var _vibrate = vibrate;
    Color _color;
    switch (type) {
      case SnackBarType.log:
        _color =
            Get.isDarkMode ? const Color(0xFF666666) : const Color(0xFF333333);
        break;
      case SnackBarType.success:
        _color = const Color(0xFF239923);
        break;
      case SnackBarType.warn:
        _color = const Color(0xFF996633);
        break;
      case SnackBarType.info:
        _color = Get.theme.primaryColor;
        break;
      case SnackBarType.error:
        _vibrate = true; //always vibrate on error
        _color =
            Get.isDarkMode ? const Color(0xFFE84F4F) : const Color(0xFFC62323);
        break;
    }

    Duration _duration;
    switch (duration) {
      case SnackBarDuration.instant:
        _duration = const Duration(seconds: 1);
        break;
      case SnackBarDuration.quick:
        _duration = const Duration(seconds: 2);
        break;
      case SnackBarDuration.delayed:
        _duration = const Duration(seconds: 5);
        break;
      case SnackBarDuration.sloth:
        _duration = const Duration(seconds: 10);
        break;
    }

    if (_vibrate) {
      Helpers.vibrate(type: VibrationType.mid);
    }

    return Get.rawSnackbar(
        animationDuration: const Duration(
          milliseconds: 200,
        ),
        onTap: onTap,
        messageText: Center(
          child: Text(
            message,
            style: Get.textTheme.subtitle2?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        forwardAnimationCurve: Curves.easeOutCubic,
        reverseAnimationCurve: Curves.easeOutCubic,
        borderRadius: 5,
        backgroundColor: _color,
        duration: _duration,
        barBlur: 10,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10));
  }

  static void vibrate({
    VibrationType type = VibrationType.low,
  }) {
    switch (type) {
      case VibrationType.heavy:
        HapticFeedback.heavyImpact();
        break;
      case VibrationType.mid:
        HapticFeedback.mediumImpact();
        break;
      case VibrationType.low:
        HapticFeedback.lightImpact();
        break;
      case VibrationType.tap:
        HapticFeedback.selectionClick();
        break;
      default:
        HapticFeedback.vibrate();
    }
  }
}

class EmployeeSearchDelegate<T> extends SearchDelegate {
  final _maxResultSet = 15;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      CloseButton(
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: Get.back,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final employees = <int, Employee>{};
    final _homeController = Get.find<HomeController>();

    if (query.isEmpty) {
      for (final entry in _homeController.employees.entries) {
        employees[entry.key] = entry.value;
        if (employees.length >= _maxResultSet) {
          //stop loop and return results... results too long
          break;
        }
      }
    } else {
      for (final entry in _homeController.employees.entries) {
        if (entry.value.fullName.toLowerCase().contains(query.toLowerCase())) {
          employees[entry.key] = entry.value;
        }

        if (employees.length >= _maxResultSet) {
          //stop loop and return results... results too long
          break;
        }
      }
    }

    final employeeIDs = employees.keys.toList();

    if (employeeIDs.isEmpty) {
      return ListView(
        children: [
          SizedBox(
            height: Get.height * 0.25,
          ),
          EmptyListPlaceholder(
            icon: Icons.search_outlined,
            tag: 'No Match',
            instruction: 'No Employee Match For [ $query ]',
          ),
        ],
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final _id = employeeIDs[index];
        return EmployeeTileDisplay(
          employee: employees[_id]!,
          id: _id,
          onTap: (m) => Get.back<Map<int, Employee>>(result: m),
        );
      },
      itemCount: employeeIDs.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return const SizedBox();

    final employees = <int, Employee>{};
    final _homeController = Get.find<HomeController>();

    if (query.isEmpty) {
      for (final entry in _homeController.employees.entries) {
        employees[entry.key] = entry.value;
        if (employees.length >= _maxResultSet) {
          //stop loop and return results... results too long
          break;
        }
      }
    } else {
      for (final entry in _homeController.employees.entries) {
        if (entry.value.fullName.toLowerCase().contains(query.toLowerCase())) {
          employees[entry.key] = entry.value;
        }

        if (employees.length >= _maxResultSet) {
          //stop loop and return results... results too long
          break;
        }
      }
    }

    final employeeIDs = employees.keys.toList();

    if (employeeIDs.isEmpty) {
      return ListView(
        children: [
          SizedBox(
            height: Get.height * 0.25,
          ),
          EmptyListPlaceholder(
            icon: Icons.search_outlined,
            tag: 'No Match',
            instruction: 'No Employee Match For [ $query ]',
          ),
        ],
      );
    }

    return ListView.builder(
      itemBuilder: (context, index) {
        final _id = employeeIDs[index];
        return EmployeeTileDisplay(
          employee: employees[_id]!,
          id: _id,
          onTap: (m) => Get.back<Map<int, Employee>>(result: m),
        );
      },
      itemCount: employeeIDs.length,
    );
  }
}

enum SnackBarDuration { instant, quick, delayed, sloth }

enum SnackBarType { log, success, warn, info, error }

enum VibrationType { heavy, mid, low, tap }
