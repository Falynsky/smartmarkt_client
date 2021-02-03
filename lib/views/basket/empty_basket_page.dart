import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class EmptyBasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: 100,
            color: complementaryThree,
          ),
          Text(
            "Brak produktów \nw koszyku",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: complementaryThree,
              fontSize: 25,
            ),
          ),
        ],
      ),
    );
  }
}
