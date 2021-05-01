import 'package:smartmarktclient/providers/product_type_provider.dart';

class ProductTypeRepository {
  late ProductTypeProvider _productProvider;

  ProductTypeRepository() {
    _productProvider = ProductTypeProvider();
  }

  Future<Map<String, dynamic>> getProductTypes() async {
    return await _productProvider.getProductTypes();
  }
}
