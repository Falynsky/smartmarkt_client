import 'package:flutter/material.dart';
import 'package:smartmarktclient/http/http_service.dart';

class ProductProvider {
  HttpService _httpService;
  final String _addToBasketEndPoint = "/baskets_products/add";

  ProductProvider() {
    _httpService = HttpService();
  }

  Future<Map<String, dynamic>> addProductToBasket({
    @required int productId,
    int quantity,
  }) async {
    Map<String, dynamic> body = {
      "productId": productId,
      "quantity": quantity ?? 1
    };

    final response = await _httpService.post(
      url: _addToBasketEndPoint,
      postBody: body,
    );

    return response;
  }
}
