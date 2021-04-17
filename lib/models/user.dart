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

import 'dart:convert';

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

  Map<String, String> get _toMap => {
        'firstname': firstname,
        'lastname': lastname,
        'gender': gender,
        'dateOfBirth': dateOfBirth.toString(),
        'passportPhoto': passportPhoto ?? '',
        'address': address,
        'country': country,
        'state': state,
      };

  Map<String, String> toMap(Map<String, String>? additionalInfo) {
    return {..._toMap, ...?additionalInfo};
  }

  String toJson(Map<String, String>? additionalInfo) {
    return jsonEncode({..._toMap, ...?additionalInfo});
  }
}
