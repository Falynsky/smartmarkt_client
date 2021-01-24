import 'package:smartmarktclient/providers/basket_provider.dart';

class BasketRepository {
  BasketProvider _basketProvider;

  BasketRepository() {
    _basketProvider = BasketProvider();
  }

  Future<Map<String, dynamic>> loadBasketProducts() async {
    return await _basketProvider.loadBasketProducts();
  }

  Future<Map<String, dynamic>> getBasketId() async {
    return await _basketProvider.getBasketId();
  }

  Future<Map<String, dynamic>> loadBasketSummary() async {
    return await _basketProvider.loadBasketSummary();
  }

  Future<Map<String, dynamic>> removeBasketProduct(int productId) async {
    return await _basketProvider.removeBasketProduct(productId);
  }

  Future<Map<String, dynamic>> clearBasket() async {
    return await _basketProvider.clearBasket();
  }

  Future<Map<String, dynamic>> purchaseAllBasketProducts() async {
    return await _basketProvider.purchaseAllBasketProducts();
  }
}
