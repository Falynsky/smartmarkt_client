import 'package:smartmarktclient/providers/product_provider.dart';

class ProductRepository {
  late ProductProvider _productProvider;

  ProductRepository() {
    _productProvider = ProductProvider();
  }

  Future<Map<String, dynamic>> addProductToBasket({
    required int productId,
    int quantity = 1,
  }) async {
    Map<String, dynamic> productInfo = await _productProvider.addProductToBasket(
      productId: productId,
      quantity: quantity,
    );

    return productInfo;
  }

  Future<Map<String, dynamic>> removeProductFromBasket({
    required int productId,
  }) async {
    Map<String, dynamic> productInfo = await _productProvider.removeProductFromBasket(
      productId: productId,
    );

    return productInfo;
  }

  Future<Map<String, dynamic>> getProducts({
    required int productTypeId,
  }) async {
    Map<String, dynamic> productInfo = await _productProvider.getProducts(productTypeId: productTypeId);

    return productInfo;
  }
}
