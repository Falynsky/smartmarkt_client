import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_event.dart';
import 'package:smartmarktclient/bloc/scanner/scanner_state.dart';
import 'package:smartmarktclient/repositories/product_repository.dart';
import 'package:smartmarktclient/repositories/scanner_repository.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerRepository _scannerRepository;
  ProductRepository _productRepository;

  ScannerBloc() : super(InitialScannerState()) {
    _scannerRepository = ScannerRepository();
    _productRepository = ProductRepository();
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
        var isSuccess = response['success'];
        if (isSuccess) {
          Map<String, dynamic> productData = response['data'];
          if (productData.isNotEmpty) {
            yield CorrectScanState(productData: productData);
          } else {
            yield ErrorScanState();
          }
        }
      }
    } else if (event is AddProductToBasketEvent) {
      Map<String, dynamic> response = await _productRepository
          .addProductToBasket(productId: event.productId);

      String message = response['data']['msg'];
      yield AddToBasketState(
        message: message,
        key: UniqueKey(),
      );
    }
  }
}
