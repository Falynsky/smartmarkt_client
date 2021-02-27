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

  Future<bool> isServerAvailable({String storeAddress}) async {
    String barsCode = "/isAlive";
    HttpService.hostUrl = storeAddress;
    Map<String, dynamic> response = await _httpService.post(url: barsCode);
    return response['success'];
  }
}
