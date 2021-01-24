import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/models/product_type.dart';
import 'package:smartmarktclient/repositories/product_type_repository.dart';

import '../bloc.dart';

class ProductTypesBloc extends Bloc<ProductTypesEvent, ProductTypesState> {
  List<ProductType> _productTypes;
  ProductTypeRepository _productTypeRepository;

  ProductTypesBloc() : super(InitialProductTypesState()) {
    _productTypeRepository = ProductTypeRepository();
  }

  List<ProductType> get productTypes => _productTypes;

  @override
  Stream<ProductTypesState> mapEventToState(
    ProductTypesEvent event,
  ) async* {
    if (event is InitialProductTypesEvent) {
      Future<Map<String, dynamic>> productTypes =
          _productTypeRepository.getProductTypes();
      productTypes.then(
        (response) {
          if (response['success']) {
            _productTypes = [];
            final products =
                new List<Map<String, dynamic>>.from(response['data']);
            products.forEach((jsonProduct) {
              ProductType product = ProductType.fromJson(jsonProduct);
              _productTypes.add(product);
            });
          }
          add(LoadedProductTypesEvent());
        },
      );
    } else if (event is LoadedProductTypesEvent) {
      yield LoadedProductTypesState();
    }
  }
}
