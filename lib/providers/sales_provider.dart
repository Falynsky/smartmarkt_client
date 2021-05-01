import 'package:smartmarktclient/http/http_service.dart';

class SalesProvider {
  late HttpService _httpService;
  final String _endPoint = "/sales";

  SalesProvider() {
    _httpService = HttpService();
  }

  Future<Map<String, dynamic>> getSales() async {
    return await _httpService.get(url: _endPoint + '/all');
  }
}
