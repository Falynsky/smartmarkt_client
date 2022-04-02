import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:smartmarktclient/providers/configuration_provider.dart';

class ConfigurationRepository {
  late ConfigurationProvider _configurationProvider;

  ConfigurationRepository() {
    _configurationProvider = ConfigurationProvider();
  }

  Future<String> getStoreAddress() async {
    ScanResult scanResult = await _configurationProvider.scanBarsCode();
    return scanResult.rawContent;
  }

  Future<bool> isServerAvailable({
    required String storeAddress,
  }) async {
    return await _configurationProvider.isServerAvailable(
      storeAddress: storeAddress,
    );
  }
}
