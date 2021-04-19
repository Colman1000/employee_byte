import 'package:employee_byte/globals/helpers.dart';
import 'package:employee_byte/globals/theme.dart';
import 'package:employee_byte/models/employee.dart';
import 'package:employee_byte/pages/view_employee/view_employee_controller.dart';
import 'package:employee_byte/widgets/cover.dart';
import 'package:employee_byte/widgets/header.dart';
import 'package:employee_byte/widgets/passport_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewEmployee extends StatelessWidget {
  ViewEmployee({
    Key? key,
    required this.id,
    required this.employee,
  }) : super(key: key) {
    Get.put(ViewEmployeeController());
  }

  final int id;
  final Employee employee;

  @override
  Widget build(BuildContext context) {
    final _viewEmployeeController = Get.find<ViewEmployeeController>();

    final _viewItems = [
      const SizedBox(
        height: 20,
      ),
      Hero(
        tag: employee.passportPhoto ?? employee.fullName,
        child: PassportViewer(
          value: employee.passportPhoto,
          user: employee.lastname,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Align(
        child: OutlinedButton(
          onPressed: () {},
          style: ButtonStyle(
            enableFeedback: true,
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
            ),
          ),
          child: Text(employee.designation.toUpperCase()),
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Align(
        child: Text(
          '${DateTime.now().year - employee.dateOfBirth.year} Years',
          style: Get.textTheme.subtitle2,
        ),
      ),
      const SizedBox(
        height: 40,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'NATIONALITY',
                      style: Get.textTheme.caption,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      employee.country,
                      style: Get.textTheme.headline5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'STATE',
                      style: Get.textTheme.caption,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      employee.state,
                      style: Get.textTheme.headline5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 40,
      ),
      Align(
        child: Icon(
          Icons.pin_drop_outlined,
          color: AppTheme.primaryColorD.withOpacity(0.5),
          size: 45,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Align(
        child: Text(
          employee.address,
          style: Get.textTheme.headline6,
        ),
      ),
    ];

    return Cover(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Header(
            title: HeaderLeadingWidget(
              title: employee.fullName,
            ),
            actions: [
              Obx(
                () {
                  final _deleting = Get.find<ViewEmployeeController>()
                      .isDeletingEmployee
                      .value;

                  return IconButton(
                    icon: _deleting
                        ? const CupertinoActivityIndicator()
                        : const Icon(Icons.delete_outline),
                    onPressed: _deleting
                        ? null
                        : () async {
                            final confirmed = await Helpers.confirm(
                                  prompt:
                                      'Deleting this employee can not be undone',
                                  context: context,
                                ) ??
                                true;

                            if (!confirmed) {
                              return;
                            }
                            _viewEmployeeController.deleteEmployee(id);
                          },
                  );
                },
              ),
            ],
            hasBackButton: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _viewItems[index];
              },
              itemCount: _viewItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
