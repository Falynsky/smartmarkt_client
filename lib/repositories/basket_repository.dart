import 'package:smartmarktclient/providers/basket_provider.dart';

class BasketRepository {
  BasketProvider _basketProvider;

  BasketRepository() {
    _basketProvider = BasketProvider();
  }

  Future<Map<String, dynamic>> loadBasketProducts() async {
    return await _basketProvider.loadBasketProducts();
  }

  Future<Map<String, dynamic>> loadBasketSummary() async {
    return await _basketProvider.loadBasketSummary();
  }

  Future<Map<String, dynamic>> removeAllBasketProducts() async {
    return await _basketProvider.removeAllBasketProducts();
  }
}
