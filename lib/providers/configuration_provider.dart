import 'package:barcode_scan/barcode_scan.dart';
import 'package:smartmarktclient/http/http_service.dart';

class ConfigurationProvider {
  HttpService _httpService;

  ConfigurationProvider() {
    _httpService = HttpService();
  }

  Future<ScanResult> scanBarsCode() async {
    return BarcodeScanner.scan();
  }

  Future<Map<String, dynamic>> isServerAvailable({String storeAddress}) async {
    String barsCode = "/isAlive";
    HttpService.hostUrl = storeAddress;
    return await _httpService.post(url: barsCode, postBody: {});
  }
}
