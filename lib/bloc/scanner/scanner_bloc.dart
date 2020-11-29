import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_event.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_state.dart';
import 'package:smartmarktclient/repositories/scanner_repository.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerRepository _scannerRepository;

  ScannerBloc() : super(InitialScannerState()) {
    _scannerRepository = ScannerRepository();
  }

  @override
  Stream<ScannerState> mapEventToState(ScannerEvent event) async* {
    if (event is InitialScannerEvent) {
      yield InitialScannerState();
    } else if (event is GetProductInfoEvent) {
      int productCode = await _scannerRepository.getProductCode();
      if (productCode != null) {
        Map<String, dynamic> response =
            await _scannerRepository.getProductInfo(productCode: productCode);
        if (response['success']) {
          Map<String, dynamic> data = response['data'];
          if (data.isNotEmpty) {
            String name = data['name'].toString();
            String price = data['price'].toString();
            String currency = data['currency'].toString();
            yield CorrectScanState(
              name: name,
              price: price,
              currency: currency,
            );
          } else {
            yield ErrorScanState();
          }
        }
      }
    }
  }
}
