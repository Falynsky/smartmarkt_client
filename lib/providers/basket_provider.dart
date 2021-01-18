import 'package:smartmarktclient/http/http_service.dart';

class BasketProvider {
  HttpService _httpService;
  final String _endPoint = "/baskets_products";

  BasketProvider() {
    _httpService = HttpService();
  }

  Future<Map<String, dynamic>> loadBasketProducts() async {
    return await _httpService.get(url: _endPoint + '/getUserProducts');
  }

  Future<Map<String, dynamic>> loadBasketSummary() async {
    return await _httpService.get(url: _endPoint + '/getSummary');
  }

  Future<Map<String, dynamic>> removeAllBasketProducts() async {
    return await _httpService.post(url: _endPoint + '/removeAll');
  }
}
