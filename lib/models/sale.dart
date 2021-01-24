import 'package:flutter/material.dart';

class Sale {
  final int id;
  final String title;
  final String description;
  final double discount;
  final double originalPrice;
  final String docName;
  final String docType;

  Sale({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.discount,
    @required this.originalPrice,
    @required this.docName,
    @required this.docType,
  });

  Sale.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        discount = json['discount'],
        originalPrice = json['originalPrice'],
        docName = json['docName'],
        docType = json['docType'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'discount': discount,
        'originalPrice': originalPrice,
        'docName': docName,
        'docType': docType,
      };
}
