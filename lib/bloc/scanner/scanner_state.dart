import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();
}

class InitialScannerState extends ScannerState {
  @override
  List<Object> get props => [];
}

class ErrorScanState extends ScannerState {
  @override
  List<Object> get props => [];
}

class CorrectScanState extends ScannerState {
  final Map<String, dynamic> productData;

  CorrectScanState({
    @required this.productData,
  });

  @override
  List<Object> get props => [productData];
}

class AddToBasketState extends ScannerState {
  final String message;
  final Key key;

  AddToBasketState({
    @required this.message,
    @required this.key,
  });

  @override
  List<Object> get props => [
        message,
        key,
      ];
}
