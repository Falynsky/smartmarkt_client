import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class ProductsPanelBloc extends Bloc<ProductsPanelEvent, ProductsPanelState> {
  ProductsPanelBloc() : super(ProductTypesPageState());

  @override
  Stream<ProductsPanelState> mapEventToState(
    ProductsPanelEvent event,
  ) async* {
    if (event is LoadedProductTypesPageEvent) {
      yield ProductTypesPageState();
    } else if (event is SelectedTypeProductsEvent) {
      yield SelectedTypeProductsState(
        productType: event.productType,
      );
    } else {
      yield ProductTypesPageState();
    }
  }
}
