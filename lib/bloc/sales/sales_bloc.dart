import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/repositories/sales_repository.dart';

import '../bloc.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  SalesRepository _salesRepository;

  SalesBloc() : super(InitialSalesState()) {
    _salesRepository = SalesRepository();
  }

  @override
  Stream<SalesState> mapEventToState(SalesEvent event) async* {
    if (event is LoadedSalesEvent) {
      Map<String, dynamic> _sales = await _salesRepository.getSales();
      yield LoadedSalesState(sales: _sales);
    }
  }
}
