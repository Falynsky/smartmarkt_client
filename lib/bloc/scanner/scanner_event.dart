import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();
}

class InitialScannerEvent extends ScannerEvent {
  @override
  List<Object> get props => [];
}

class GetProductInfoEvent extends ScannerEvent {
  @override
  List<Object> get props => [];
}

class AddProductToBasketEvent extends ScannerEvent {
  final int productId;

  AddProductToBasketEvent({
    @required this.productId,
  });

  @override
  List<Object> get props => [
        productId,
      ];
}

class ErrorScanEvent extends ScannerEvent {
  @override
  List<Object> get props => [];
}

class CorrectScanEvent extends ScannerEvent {
  @override
  List<Object> get props => [];
}
