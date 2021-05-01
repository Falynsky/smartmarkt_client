// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:smartmarktclient/providers/scanner_provider.dart';
//
// class ScannerRepository {
//   late ScannerProvider _scannerProvider;
//
//   ScannerRepository() {
//     _scannerProvider = ScannerProvider();
//   }
//
//   Future<int> getProductCode() async {
//     ScanResult scanResult = await _scannerProvider.scanBarsCode();
//     String rawContent = scanResult.rawContent;
//     int productCode;
//     try {
//       productCode = int.parse(rawContent);
//     } catch (e) {
//       return -1;
//     }
//
//     return productCode;
//   }
//
//   Future<Map<String, dynamic>> getProductInfo({
//     required int productCode,
//   }) async {
//     Map<String, dynamic> productInfo =
//         await _scannerProvider.getProductInfo(productCode: productCode);
//
//     return productInfo;
//   }
//
//   Future<Map<String, dynamic>> addProductToBasket({
//     required int productCode,
//   }) async {
//     Map<String, dynamic> productInfo =
//         await _scannerProvider.getProductInfo(productCode: productCode);
//
//     return productInfo;
//   }
// }
