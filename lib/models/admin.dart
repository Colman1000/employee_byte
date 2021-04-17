import 'package:employee_byte/models/user.dart';

class Admin extends User {
  Admin({
    required String firstname,
    required String lastname,
    required String gender,
    required DateTime dateOfBirth,
    required String address,
    required String country,
    required String state,
    required this.password,
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
  final String password;
}
