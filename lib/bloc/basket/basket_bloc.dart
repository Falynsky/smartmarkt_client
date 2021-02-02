import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/models/basket_product.dart';
import 'package:smartmarktclient/repositories/basket_repository.dart';
import 'package:smartmarktclient/repositories/product_repository.dart';

import '../bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketRepository _basketRepository;
  ProductRepository _productRepository;
  double _basketSummary;
  double _summaryAfterDiscount;
  String _currentUserBasketId;
  List<BasketProduct> _basketProducts;

  List<BasketProduct> get basketProducts => _basketProducts;

  double get basketSummary => _basketSummary;

  double get summaryAfterDiscount => _summaryAfterDiscount;

  String get currentUserBasketId => _currentUserBasketId;

  BasketBloc() : super(InitialBasketState()) {
    _basketRepository = BasketRepository();
    _productRepository = ProductRepository();
  }

  @override
  Stream<BasketState> mapEventToState(BasketEvent event) async* {
    if (event is LoadingBasketEvent) {
      Key uniqueKey = UniqueKey();
      yield LoadingBasketState(uniqueKey);
      if (_currentUserBasketId == null) {
        _getBasketId();
      }
      _loadBasketProducts();
    } else if (event is LoadingSummaryBasketEvent) {
      _loadBasketSummary();
    } else if (event is RemoveBasketProductEvent) {
      _removeObject(event.index);
    } else if (event is ClearBasketEvent) {
      _clearBasket();
    } else if (event is RemoveOneFromBasketEvent) {
      Map<String, dynamic> response =
          await _productRepository.removeProductFromBasket(
        productId: event.productId,
        quantity: 1,
      );
      add(LoadingBasketEvent());
      String message = response['data']['msg'];
      add(ShowBasketSnackBarEvent(message: message));
    } else if (event is AddOneToBasketEvent) {
      Map<String, dynamic> response = await _productRepository
          .addProductToBasket(productId: event.productId);
      add(LoadingBasketEvent());
      String message = response['data']['msg'];
      add(ShowBasketSnackBarEvent(message: message));
    } else if (event is ShowBasketSnackBarEvent) {
      yield ShowBasketSnackBarState(message: event.message);
    } else if (event is PurchaseBasketProductsEvent) {
      _purchaseAllBasketProducts();
    } else if (event is LoadedBasketEvent) {
      yield LoadedBasketState();
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
      (response) {
        if (response['success']) {
          _collectBasketProducts(response);
        }
        add(LoadingSummaryBasketEvent());
      },
    );
  }

  void _collectBasketProducts(Map<String, dynamic> response) {
    _basketProducts = [];
    final basketProducts = List<Map<String, dynamic>>.from(response['data']);
    basketProducts.forEach((jsonBasketProduct) {
      BasketProduct basketProduct = BasketProduct.fromJson(jsonBasketProduct);
      _basketProducts.add(basketProduct);
    });
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

  void _removeObject(int index) {
    int productId = basketProducts[index].productId;
    Future<Map<String, dynamic>> removeBasketProduct =
        _basketRepository.removeBasketProduct(productId);
    removeBasketProduct.then(
      (response) {
        if (response['success'] == true) {
          add(LoadingBasketEvent());
          String message = response['data']['msg'];
          add(ShowBasketSnackBarEvent(message: message));
        }
      },
    );
  }

  void _clearBasket() {
    Future<Map<String, dynamic>> removeAllProducts =
        _basketRepository.clearBasket();
    removeAllProducts.then(
      (response) {
        if (response['success'] == true) {
          add(LoadingBasketEvent());
          String message = response['data']['msg'];
          add(ShowBasketSnackBarEvent(message: message));
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
