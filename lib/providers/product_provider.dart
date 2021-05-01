import 'package:smartmarktclient/http/http_service.dart';

class ProductProvider {
late HttpService _httpService;
late final String _addToBasketEndPoint = "/baskets_products/add";
late final String _removeFromBasketEndPoint = "/baskets_products/remove";
late final String _getProductsEndPoint = "/products/typeId";

  ProductProvider() {
    _httpService = HttpService();
  }

  Future<Map<String, dynamic>> addProductToBasket({
    required int productId,
    required int quantity,
  }) async {
    Map<String, dynamic> body = {
      "productId": productId,
      "quantity": quantity
    };

    final response = await _httpService.post(
      url: _addToBasketEndPoint,
      postBody: body,
    );

    return response;
  }

  Future<Map<String, dynamic>> removeProductFromBasket({
    required int productId,
  }) async {
    Map<String, dynamic> body = {
      "productId": productId,
      "quantity": 1,
    };

    final response = await _httpService.post(
      url: _removeFromBasketEndPoint,
      postBody: body,
    );

    return response;
  }

  Future<Map<String, dynamic>> getProducts({
    required int productTypeId,
  }) async {
    Map<String, dynamic> body = {
      "id": productTypeId,
    };

    final response = await _httpService.post(
      url: _getProductsEndPoint,
      postBody: body,
    );

    return response;
  }
}
