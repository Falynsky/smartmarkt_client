import 'package:flutter/material.dart';
import 'package:smartmarktclient/http/http_service.dart';

class SignUpProvider {
  HttpService _httpService;
  final String _endPoint = "/signUp";

  SignUpProvider() {
    _httpService = HttpService();
  }

  Future<Map<String, dynamic>> register({
    @required String mail,
    @required String login,
    @required String password,
    @required String firstName,
    @required String lastName,
  }) async {
    Map<String, dynamic> body = {
      "mail": mail,
      "username": login,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
      "licenceKey": "__________"
    };
    return await _httpService.post(
      url: '$_endPoint/register',
      postBody: body,
    );
  }
}
