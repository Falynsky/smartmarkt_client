import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartmarktclient/providers/scanner_provider.dart';

class ScannerRepository {
  ScannerProvider _scannerProvider;

  ScannerRepository() {
    _scannerProvider = ScannerProvider();
  }

  Future<int> getProductCode() async {
    ScanResult scanResult = await _scannerProvider.scanBarsCode();
    int productCode = int.parse(scanResult.rawContent);
    return productCode;
  }

  Future<Map<String, dynamic>> getProductInfo({
    @required int productCode,
  }) async {
    Map<String, dynamic> productInfo =
        await _scannerProvider.getProductInfo(productCode: productCode);

    return productInfo;
  }

  Future<Map<String, dynamic>> addProductToBasket({
    @required int productCode,
  }) async {
    Map<String, dynamic> productInfo =
        await _scannerProvider.getProductInfo(productCode: productCode);

    return productInfo;
  }
}
