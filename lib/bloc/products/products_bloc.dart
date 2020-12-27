import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

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
