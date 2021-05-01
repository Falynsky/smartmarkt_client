// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:smartmarktclient/http/http_service.dart';
//
// class ScannerProvider {
//  late HttpService _httpService;
//
//   ScannerProvider() {
//     _httpService = HttpService();
//   }
//
//   Future<ScanResult> scanBarsCode() async {
//     return BarcodeScanner.scan();
//   }
//
//   Future<Map<String, dynamic>> getProductInfo({required int productCode}) async {
//     String barsCode = "/barsCodes/$productCode";
//     final response = await _httpService.get(url: barsCode);
//     Map<String, dynamic> productInfo = response;
//     return productInfo;
//   }
// }
