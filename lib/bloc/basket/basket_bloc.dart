import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/repositories/basket_repository.dart';

import '../bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketRepository _basketRepository;
  double _basketSummary;
  List<Map<String, dynamic>> _basketProducts;

  List<Map<String, dynamic>> get basketProducts => _basketProducts;

  double get basketSummary => _basketSummary;

  BasketBloc() : super(InitialBasketState()) {
    _basketRepository = BasketRepository();
  }

  @override
  Stream<BasketState> mapEventToState(BasketEvent event) async* {
    if (event is LoadingBasketEvent) {
      yield LoadingBasketState();
      _loadBasketProducts();
    } else if (event is LoadingSummaryBasketEvent) {
      _loadBasketSummary();
    } else if (event is RemoveBasketProductsEvent) {
      _removeAllBasketProducts();
    } else if (event is LoadedBasketEvent) {
      yield LoadedBasketState(
        basketProducts: _basketProducts,
        basketSummary: _basketSummary,
      );
    }
  }

  void _loadBasketProducts() {
    Future<Map<String, dynamic>> basketProducts =
        _basketRepository.loadBasketProducts();
    basketProducts.then(
      (response) => {
        if (response['success'])
          {
            _basketProducts = List<Map<String, dynamic>>.from(response['data']),
            add(LoadingSummaryBasketEvent())
          }
      },
    );
  }

  void _loadBasketSummary() {
    Future<Map<String, dynamic>> basketSummary =
        _basketRepository.loadBasketSummary();
    basketSummary.then(
      (response) => {
        if (response['success'])
          {
            _basketSummary = response['data']['summary'],
            add(LoadedBasketEvent())
          }
      },
    );
  }

  void _removeAllBasketProducts() {
    Future<Map<String, dynamic>> removeAllProducts =
        _basketRepository.removeAllBasketProducts();
    removeAllProducts.then(
      (response) => {
        if (response['success'] == true)
          {
            add(LoadingBasketEvent()),
          }
      },
    );
  }
}
