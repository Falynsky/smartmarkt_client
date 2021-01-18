import 'package:equatable/equatable.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();
}

class LoadingBasketEvent extends BasketEvent {
  @override
  List<Object> get props => [];
}

class LoadingSummaryBasketEvent extends BasketEvent {
  @override
  List<Object> get props => [];
}

class LoadedBasketEvent extends BasketEvent {
  final List<Map<String, dynamic>> basketProducts;

  LoadedBasketEvent({
    this.basketProducts,
  });

  @override
  List<Object> get props => [
        basketProducts,
      ];
}

class RemoveBasketProductsEvent extends BasketEvent {
  @override
  List<Object> get props => [];
}
