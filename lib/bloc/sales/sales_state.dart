import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SalesState extends Equatable {
  const SalesState();
}

class InitialSalesState extends SalesState {
  @override
  List<Object> get props => [];
}

class LoadedSalesState extends SalesState {
  final Map<String, dynamic> sales;

  LoadedSalesState({@required this.sales});

  @override
  List<Object> get props => [
        sales,
      ];
}
