import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/models/sale.dart';
import 'package:smartmarktclient/repositories/sales_repository.dart';

import '../bloc.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  SalesRepository _salesRepository;
  List<Sale> _sales;
  List<Sale> get sales => _sales;

  SalesBloc() : super(SalesLoadingState()) {
    _salesRepository = SalesRepository();
  }

  @override
  Stream<SalesState> mapEventToState(SalesEvent event) async* {
    if (event is SalesLoadingEvent) {
      yield SalesLoadingState();
      Future<Map<String, dynamic>> sales = _salesRepository.getSales();
      sales.then((data) {
        if (data['success']) {
          _sales = [];
          final sales = List<Map<String, dynamic>>.from(data['data']);
          sales.forEach((sale) {
            _sales.add(Sale.fromJson(sale));
          });
        }
        add(LoadedSalesEvent());
      });
    } else if (event is LoadedSalesEvent) {
      yield LoadedSalesState(sales: _sales);
    }
  }
}
