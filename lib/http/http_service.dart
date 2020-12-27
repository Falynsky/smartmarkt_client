import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpService {
//  final String hostUrl = "https://smartmarkt-server.herokuapp.com";
  final String hostUrl = "http://192.168.21.4:8080";
  static final Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7',
    'Connection': 'keep-alive',
  };

  static void clearAuthHeader() {
    headers.remove('Auth');
  }

  //todo: add interceptors

  Future<Map<String, dynamic>> post({
    @required String url,
    Map<String, dynamic> body,
  }) async {
    final msg = jsonEncode(body);
    var response = await http.post(
      hostUrl + url,
      headers: headers,
      body: msg,
    );
    var data = json.decode(utf8.decode(response.bodyBytes));
    var statusCode = response.statusCode;

    if (statusCode >= 400) {
      return collectResponseData(false, statusCode, data);
    } else if (statusCode >= 200 && statusCode <= 299) {
      if (statusCode == 200 && url == '/auth/login') {
        headers['Auth'] = 'Wave ' + data['token'];
      }
      return collectResponseData(true, statusCode, data);
    }
    return collectResponseData(false, statusCode, data);
  }

  Map<String, Object> collectResponseData(bool success, int statusCode, data) {
    Map<String, Object> responseData = {
      "success": success,
      "statusCode": statusCode,
      "data": data,
    };
    return responseData;
  }

  Future<Map<String, dynamic>> get({
    @required String url,
  }) async {
    var response = await http.get(
      hostUrl + url,
      headers: headers,
    );
    var data = response.body;
    var decodedBody;
    if (data.isNotEmpty) {
      decodedBody = json.decode(utf8.decode(response.bodyBytes));
    } else {
      decodedBody = data;
    }
    var statusCode = response.statusCode;
    if (statusCode == 200) {
      return {
        "success": true,
        "data": decodedBody,
      };
    } else {
      return {
        "success": false,
        "statusCode": statusCode,
      };
    }
  }
}
