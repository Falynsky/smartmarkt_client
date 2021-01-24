import 'package:equatable/equatable.dart';

abstract class ProductTypesEvent extends Equatable {
  const ProductTypesEvent();
}

class InitialProductTypesEvent extends ProductTypesEvent {
  final int productTypeId;

  InitialProductTypesEvent({this.productTypeId});

  @override
  List<Object> get props => [
        productTypeId,
      ];
}

class LoadedProductTypesEvent extends ProductTypesEvent {
  LoadedProductTypesEvent();

  @override
  List<Object> get props => [];
}
