import 'package:flutter/material.dart';
import 'package:smartmarktclient/providers/product_provider.dart';

class ProductRepository {
  ProductProvider _productProvider;

  ProductRepository() {
    _productProvider = ProductProvider();
  }

  Future<Map<String, dynamic>> addProductToBasket({
    @required int productId,
    int quantity,
  }) async {
    Map<String, dynamic> productInfo =
        await _productProvider.addProductToBasket(
      productId: productId,
      quantity: quantity,
    );

    return productInfo;
  }

  Future<Map<String, dynamic>> getProducts({
    int productTypeId,
  }) async {
    Map<String, dynamic> productInfo =
        await _productProvider.getProducts(productTypeId: productTypeId);

    return productInfo;
  }
}
