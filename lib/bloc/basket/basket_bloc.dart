import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/repositories/basket_repository.dart';

import '../bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketRepository _basketRepository;
  double _basketSummary;
  double _summaryAfterDiscount;
  String _currentUserBasketId;
  List<Map<String, dynamic>> _basketProducts;

  List<Map<String, dynamic>> get basketProducts => _basketProducts;

  double get basketSummary => _basketSummary;

  double get summaryAfterDiscount => _summaryAfterDiscount;

  String get currentUserBasketId => _currentUserBasketId;

  BasketBloc() : super(InitialBasketState()) {
    _basketRepository = BasketRepository();
  }

  @override
  Stream<BasketState> mapEventToState(BasketEvent event) async* {
    if (event is LoadingBasketEvent) {
      yield LoadingBasketState();
      if (_currentUserBasketId == null) {
        _getBasketId();
      }
      _loadBasketProducts();
    } else if (event is LoadingSummaryBasketEvent) {
      _loadBasketSummary();
    } else if (event is RemoveBasketProductsEvent) {
      _removeAllBasketProducts();
    } else if (event is PurchaseBasketProductsEvent) {
      _purchaseAllBasketProducts();
    } else if (event is LoadedBasketEvent) {
      yield LoadedBasketState(
        basketProducts: _basketProducts,
        basketSummary: _basketSummary,
      );
    }
  }

  Future<void> _getBasketId() async {
    Map<String, dynamic> response = await _basketRepository.getBasketId();
    if (response['success']) {
      _currentUserBasketId = response['data']['basketId'].toString();
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
            _summaryAfterDiscount = response['data']['summaryAfterDiscount'],
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

  void _purchaseAllBasketProducts() {
    Future<Map<String, dynamic>> removeAllProducts =
        _basketRepository.purchaseAllBasketProducts();
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
