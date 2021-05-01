import 'package:equatable/equatable.dart';
import 'package:smartmarktclient/models/product_type.dart';

abstract class ProductsPanelEvent extends Equatable {
  const ProductsPanelEvent();
}

class LoadedProductTypesPageEvent extends ProductsPanelEvent {
  @override
  List<Object> get props => [];
}

class SelectedTypeProductsEvent extends ProductsPanelEvent {
  final ProductType productType;

  SelectedTypeProductsEvent({
    required this.productType,
  });

  @override
  List<Object> get props => [
        productType,
      ];
}
