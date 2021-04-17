import 'package:get/get.dart';

class AuthController extends GetxController {
  final _currentPage = AuthPage.signIn.obs;
  final _prevPage = AuthPage.signIn.obs;

  void goTo(AuthPage value) {
    _prevPage.value = _currentPage.value;
    _currentPage.value = value;
  }

  AuthPage get currentPage => _currentPage.value;

  AuthPage get prevPage => _prevPage.value;
}

enum AuthPage { signIn, signUp }
