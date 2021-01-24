import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smartmarktclient/models/sale.dart';

abstract class SalesState extends Equatable {
  const SalesState();
}

class InitialSalesState extends SalesState {
  @override
  List<Object> get props => [];
}

class SalesLoadingState extends SalesState {
  @override
  List<Object> get props => [];
}

class LoadedSalesState extends SalesState {
  final List<Sale> sales;

  LoadedSalesState({@required this.sales});

  @override
  List<Object> get props => [
        sales,
      ];
}
