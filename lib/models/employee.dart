import 'package:employee_byte/models/user.dart';

class Employee extends User {
  Employee({
    required String firstname,
    required String lastname,
    required String gender,
    required DateTime dateOfBirth,
    required String address,
    required String country,
    required String state,
    required this.designation,
    String? passportPhoto,
  }) : super(
          firstname: firstname,
          lastname: lastname,
          gender: gender,
          dateOfBirth: dateOfBirth,
          address: address,
          country: country,
          state: state,
          passportPhoto: passportPhoto,
        );

  factory Employee.fromMap(Map<String, Object?> m) {
    return Employee(
      firstname: m['firstname'].toString(),
      lastname: m['lastname'].toString(),
      gender: m['gender'].toString(),
      dateOfBirth: DateTime.parse(m['dateOfBirth'].toString()),
      address: m['address'].toString(),
      country: m['country'].toString(),
      state: m['state'].toString(),
      designation: m['designation'].toString(),
    );
  }

  final String designation;

  @override
  Map<String, String> toMap({Map<String, String>? additionalInfo}) {
    return super.toMap(
      additionalInfo: {'designation': designation},
    );
  }
}
