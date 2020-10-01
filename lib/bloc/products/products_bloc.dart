import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:smartmarktclient/bloc/products/products_event.dart';
import 'package:smartmarktclient/bloc/products/products_state.dart';

import '../bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductTypesState());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is LoadedProductTypesEvent) {
      yield ProductTypesState();
    } else if (event is SelectedTypeProductsEvent) {
      yield SelectedTypeProductsState(
        productType: event.productType,
      );
    } else {
      yield ProductTypesState();
    }
  }
}
