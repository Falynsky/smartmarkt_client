import 'package:flutter/material.dart';
import 'package:smartmarktclient/providers/login_provider.dart';

class LoginRepository {
  LoginProvider _loginProvider;

  LoginRepository() {
    _loginProvider = LoginProvider();
  }

  Future<Map<String, dynamic>> login({
    @required String login,
    @required String password,
  }) async {
    return await _loginProvider.login(
      login: login,
      password: password,
    );
  }
}
