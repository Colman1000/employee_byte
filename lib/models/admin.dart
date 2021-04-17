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
    required this.username,
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

  factory Admin.fromMap(Map<String, Object?> m) {
    return Admin(
      firstname: m['firstname'].toString(),
      lastname: m['lastname'].toString(),
      gender: m['gender'].toString(),
      dateOfBirth: DateTime.parse(m['dateOfBirth'].toString()),
      address: m['address'].toString(),
      country: m['country'].toString(),
      state: m['state'].toString(),
      password: m['password'].toString(),
      username: m['username'].toString(),
    );
  }

  final String password;
  final String username;
}
