import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SalesEvent extends Equatable {
  const SalesEvent();
}

class LoadedSalesEvent extends SalesEvent {
  final Map<String, dynamic> sales;

  LoadedSalesEvent({@required this.sales});

  @override
  List<Object> get props => [
        sales,
      ];
}
