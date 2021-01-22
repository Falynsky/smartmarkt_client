import 'package:smartmarktclient/http/http_service.dart';

class ProfileProvider {
  HttpService _httpService;
  final String _profileEndPoint = "/profile";
  final String _historyEndPoint = "/profile";

  ProfileProvider() {
    _httpService = HttpService();
  }
}
