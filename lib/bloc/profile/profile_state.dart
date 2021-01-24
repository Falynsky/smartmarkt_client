import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:smartmarktclient/models/product_history.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class InitialProfileState extends ProfileState {
  @override
  List<Object> get props => [];
}

class LoadProfileScreenState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ShowBasketHistoryDialogState extends ProfileState {
  final Key key;
  final List<ProductHistory> productsList;
  final String purchasedDate;
  final String productSummary;

  ShowBasketHistoryDialogState({
    @required this.key,
    @required this.productsList,
    @required this.purchasedDate,
    @required this.productSummary,
  });

  @override
  List<Object> get props => [
        key,
        productsList,
        purchasedDate,
        productSummary,
      ];
}
