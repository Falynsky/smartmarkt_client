import 'package:flutter/material.dart';
import 'package:smartmarktclient/providers/sign_up_provider.dart';

class SignUpRepository {
  SignUpProvider _signUpProvider;

  SignUpRepository() {
    _signUpProvider = SignUpProvider();
  }

  Future<Map<String, dynamic>> register({
    @required String login,
    @required String password,
    @required String firstName,
    @required String lastName,
  }) async {
    return await _signUpProvider.register(
      login: login,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
