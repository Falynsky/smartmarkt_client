import 'package:smartmarktclient/http/http_service.dart';

class ProductTypeProvider {
  late HttpService _httpService;
  late final String getProductTypesEndpoint = "/productType/all";

  ProductTypeProvider() {
    _httpService = HttpService();
  }

  Future<Map<String, dynamic>> getProductTypes() async {
    return await _httpService.get(url: getProductTypesEndpoint);
  }
}
