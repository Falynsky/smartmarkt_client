// import 'dart:async';
//
// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:smartmarktclient/bloc/scanner/scanner_event.dart';
// import 'package:smartmarktclient/bloc/scanner/scanner_state.dart';
// import 'package:smartmarktclient/repositories/product_repository.dart';
// import 'package:smartmarktclient/repositories/scanner_repository.dart';
//
// class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
//   late ScannerRepository _scannerRepository;
//   late ProductRepository _productRepository;
//
//   ScannerBloc() : super(InitialScannerState()) {
//     _scannerRepository = ScannerRepository();
//     _productRepository = ProductRepository();
//   }
//
//   @override
//   Stream<ScannerState> mapEventToState(ScannerEvent event) async* {
//     if (event is InitialScannerEvent) {
//       yield InitialScannerState();
//     } else if (event is GetProductInfoEvent) {
//       yield* _getProductInfo();
//     } else if (event is AddProductToBasketEvent) {
//       yield* _addProductToBasket(event);
//     }
//   }
//
//   Stream<ScannerState> _getProductInfo() async* {
//     int productCode = await _scannerRepository.getProductCode();
//     if (productCode != -1) {
//       Map<String, dynamic> response = await _scannerRepository.getProductInfo(productCode: productCode);
//       bool isSuccess = response['success'];
//       if (isSuccess) {
//         Map<String, dynamic> productData = response['data'];
//         if (productData.isNotEmpty) {
//           yield CorrectScanState(
//             key: UniqueKey(),
//             productData: productData,
//           );
//         } else {
//           yield ErrorScanState(key: UniqueKey());
//         }
//       }
//     } else {
//       yield ErrorScanState(key: UniqueKey());
//     }
//   }
//
//   Stream<ScannerState> _addProductToBasket(AddProductToBasketEvent event) async* {
//     Map<String, dynamic> response = await _productRepository.addProductToBasket(
//       productId: event.productId,
//     );
//
//     String message = response['data']['msg'];
//     yield AddToBasketState(
//       message: message,
//       key: UniqueKey(),
//     );
//   }
// }
