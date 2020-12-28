import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/repositories/sales_repository.dart';

import '../bloc.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  SalesRepository _salesRepository;
  List<Map<String, dynamic>> _sales;

  SalesBloc() : super(InitialSalesState()) {
    _salesRepository = SalesRepository();
  }

  @override
  Stream<SalesState> mapEventToState(SalesEvent event) async* {
    if (event is SalesLoadingEvent) {
      yield SalesLoadingState();
      Future<Map<String, dynamic>> sales = _salesRepository.getSales();
      sales.then((data) => {
            if (data['success'])
              {
                _sales = List<Map<String, dynamic>>.from(data['data']),
                add(LoadedSalesEvent())
              }
          });
    } else if (event is LoadedSalesEvent) {
      yield LoadedSalesState(sales: _sales);
    }
  }
}
