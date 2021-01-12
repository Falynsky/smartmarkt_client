import 'package:smartmarktclient/providers/sales_provider.dart';

class SalesRepository {
  SalesProvider _salesProvider;

  SalesRepository() {
    _salesProvider = SalesProvider();
  }

  Future<Map<String, dynamic>> getSales() async {
    return await _salesProvider.getSales();
  }
}
