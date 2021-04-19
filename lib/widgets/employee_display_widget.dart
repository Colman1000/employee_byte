import 'package:employee_byte/models/employee.dart';
import 'package:employee_byte/widgets/passport_viewer.dart';
import 'package:flutter/material.dart';

class EmployeeTileDisplay extends StatelessWidget {
  const EmployeeTileDisplay({
    Key? key,
    required this.employee,
    required this.id,
    required this.onTap,
  }) : super(key: key);

  final Employee employee;
  final int id;
  final void Function(Map<int, Employee>) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: ListTile(
        title: Text(employee.fullName),
        subtitle: Text(employee.designation),
        leading: SizedBox(
          height: 50,
          width: 50,
          child: Hero(
            tag: employee.passportPhoto ?? employee.fullName,
            child: PassportViewer(
              size: 50,
              value: employee.passportPhoto,
              user: employee.lastname,
            ),
          ),
        ),
        trailing: const Icon(Icons.person_outline),
        enableFeedback: true,
        onTap: () {
          onTap(
            <int, Employee>{id: employee},
          );
        },
      ),
    );
  }
}
