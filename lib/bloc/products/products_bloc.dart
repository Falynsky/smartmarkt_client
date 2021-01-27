import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/models/product.dart';
import 'package:smartmarktclient/repositories/product_repository.dart';

import '../bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductRepository _productRepository;
  List<Product> _products;
  int _productTypeId;

  ProductsBloc() : super(InitialProductsState()) {
    _productRepository = ProductRepository();
  }

  List<Product> get products => _products;

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is InitialProductsEvent) {
      _productTypeId = event.productTypeId;
      _getProducts(event);
    } else if (event is AddToBasketEvent) {
      Map<String, dynamic> response =
          await _productRepository.addProductToBasket(
        productId: event.productId,
        quantity: event.quantity,
      );

      if (response['success'] == true) {
        add(AddToBasketSucceedEvent());
      } else {
        String msg = response['data']['msg'];
        add(AddToBasketUnSucceedEvent(msg));
      }
      add(InitialProductsEvent(productTypeId: _productTypeId));
    } else if (event is LoadedProductsEvent) {
      yield LoadedProductsState();
    } else if (event is AddToBasketSucceedEvent) {
      yield AddToBasketSucceedState(UniqueKey());
    } else if (event is AddToBasketUnSucceedEvent) {
      yield AddToBasketUnSucceedState(UniqueKey(), event.msg);
    }
  }

  void _getProducts(InitialProductsEvent event) {
    Future<Map<String, dynamic>> getProducts =
        _productRepository.getProducts(productTypeId: event.productTypeId);
    getProducts.then(
      (response) {
        if (response['success']) {
          _products = [];
          final products =
              new List<Map<String, dynamic>>.from(response['data']);
          products.forEach((jsonProduct) {
            Product product = Product.fromJson(jsonProduct);
            _products.add(product);
          });
        }
        add(LoadedProductsEvent());
      },
    );
  }
}
