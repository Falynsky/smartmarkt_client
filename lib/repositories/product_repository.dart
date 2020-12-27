import 'package:smartmarktclient/providers/product_provider.dart';

class ProductRepository {
  ProductProvider _productProvider;

  ProductRepository() {
    _productProvider = ProductProvider();
  }

  Future<Map<String, dynamic>> addProductToBasket({
    int productId,
  }) async {
    Map<String, dynamic> productInfo =
        await _productProvider.addProductToBasket(productId: productId);

    return productInfo;
  }
}
