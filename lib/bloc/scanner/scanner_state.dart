import 'package:equatable/equatable.dart';

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
  final String name;
  final String price;
  final String currency;

  CorrectScanState({
    this.name,
    this.price,
    this.currency,
  });

  @override
  List<Object> get props => [
        name,
        price,
        currency,
      ];
}
