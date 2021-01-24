import 'package:flutter/material.dart';

class ProductType {
  int id;
  String name;

  ProductType({
    @required this.id,
    @required this.name,
  });

  ProductType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
