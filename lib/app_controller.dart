import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'models/admin.dart';
import 'models/country.dart';

class AppController extends GetxController {
  final user = Rx<Admin?>(null);

  final _countries = <Country>[].obs;

  void logout() {
    user.value = null;
  }

  Future<List<Country>> get countries async {
    if (_countries.isNotEmpty) return _countries.value;

    final http = Req();
    final res = await http.get<Map<String, dynamic>>(
      Req.url,
    );

    _countries.value = await compute(parseCountries, res.body);
    return _countries.value;
  }
}

class Req extends GetConnect {
  static String url = 'https://api.printful.com/countries/';
}

List<Country> parseCountries(Map<String, dynamic>? responseBody) {
  if (responseBody == null) return [];
  final parsed = responseBody['result'] as List<dynamic>;
  return parsed.map<Country>((json) {
    return Country.fromJson(json as Map);
  }).toList();
}
