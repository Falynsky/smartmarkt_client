import 'package:smartmarktclient/http/http_service.dart';

class LoginProvider {
  late HttpService _httpService;
  final String _endPoint = "/auth";

  LoginProvider() {
    _httpService = HttpService();
  }

  Future<Map<String, dynamic>> login({
    required String login,
    required String password,
  }) async {
    Map<String, dynamic> body = {
      "username": login,
      "password": password,
    };
    return await _httpService.post(
      url: '$_endPoint/login',
      postBody: body,
    );
  }
}
