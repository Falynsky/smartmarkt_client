import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpService {
//  final String hostUrl = "https://smartmarkt-server.herokuapp.com";
  static String hostUrl = "http://192.168.21.4:8080";
  static final Map<String, String> headers = {
    'Content-type': 'application/json; charset=UTF-8',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7',
    'Connection': 'keep-alive',
  };

  static void clearAuthHeader() {
    headers.remove('Auth');
  }

  Future<Map<String, dynamic>> post({
    @required String url,
    Map<String, dynamic> postBody,
  }) async {
    final encodedBody = jsonEncode(postBody);
    http.Response response = await http.post(
      hostUrl + url,
      headers: headers,
      body: encodedBody,
    );

    String body = response.body;
    Map<String, Object> decodedBody = {};

    if (body.isNotEmpty) {
      String decode = utf8.decode(response.bodyBytes);
      decodedBody = json.decode(decode);
    } else {
      decodedBody = {};
    }

    int statusCode = response.statusCode;
    dynamic data = _getDataFromDataBody(decodedBody);
    if (statusCode >= 400) {
      return _collectResponseData(false, statusCode, data);
    } else if (statusCode >= 200 && statusCode <= 299) {
      if (statusCode == 200 && url == '/auth/login') {
        headers['Auth'] = 'Wave ' + data['token'];
      }
      return _collectResponseData(true, statusCode, data);
    }
    return _collectResponseData(false, statusCode, data);
  }

  dynamic _getDataFromDataBody(Map<String, dynamic> dataBody) {
    if (dataBody.containsKey('data')) {
      return dataBody['data'];
    }
    return dataBody;
  }

  Map<String, dynamic> _collectResponseData(
    bool success,
    int statusCode,
    dynamic data,
  ) {
    Map<String, dynamic> responseData = {
      "success": success,
      "statusCode": statusCode,
      "data": data,
    };
    return responseData;
  }

  Future<Map<String, dynamic>> get({
    @required String url,
  }) async {
    http.Response response = await http.get(
      hostUrl + url,
      headers: headers,
    );
    String data = response.body;
    Map<String, Object> decodedBody = {};
    if (data.isNotEmpty) {
      String decode = utf8.decode(response.bodyBytes);
      decodedBody = json.decode(decode);
    } else {
      decodedBody = {};
    }
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      return decodedBody;
    } else {
      return {
        "success": false,
        "statusCode": statusCode,
      };
    }
  }
}
