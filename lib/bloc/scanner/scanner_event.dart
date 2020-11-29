import 'package:equatable/equatable.dart';

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

class ErrorScanEvent extends ScannerEvent {
  @override
  List<Object> get props => [];
}

class CorrectScanEvent extends ScannerEvent {
  @override
  List<Object> get props => [];
}
