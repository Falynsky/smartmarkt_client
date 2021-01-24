import 'package:flutter/material.dart';

class BasketHistory {
  final int id;
  final String purchasedDateTime;
  final double purchasedPriceSummary;

  BasketHistory({
    @required this.id,
    @required this.purchasedDateTime,
    @required this.purchasedPriceSummary,
  });

  BasketHistory.fromJson(Map<String, dynamic> json)
      : id = json['basketHistoryId'],
        purchasedDateTime = json['purchasedDateTime'],
        purchasedPriceSummary = json['purchasedPriceSummary'];

  Map<String, dynamic> toJson() => {
        'basketHistoryId': id,
        'purchasedDateTime': purchasedDateTime,
        'purchasedPriceSummary': purchasedPriceSummary,
      };
}
