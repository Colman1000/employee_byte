/*
* FIELDS
*
○ Firstname
○ Lastname
○ Gender
○ Date of birth
○ Passport photo
○ Address
○ Country
○ State
*
* */

abstract class User {
  User({
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.dateOfBirth,
    required this.address,
    required this.country,
    required this.state,
    this.passportPhoto,
  });

  final String firstname;
  final String lastname;
  final String gender;
  final DateTime dateOfBirth;
  final String? passportPhoto;
  final String address;
  final String country;
  final String state;
}
