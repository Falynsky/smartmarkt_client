import 'package:smartmarktclient/providers/login_provider.dart';

class LoginRepository {
  late LoginProvider _loginProvider;

  LoginRepository() {
    _loginProvider = LoginProvider();
  }

  Future<Map<String, dynamic>> login({
    required String login,
    required String password,
  }) async {
    return await _loginProvider.login(
      login: login,
      password: password,
    );
  }
}
