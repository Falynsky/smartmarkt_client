import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class EmptyHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: complementaryThree.withOpacity(0.7),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emptyHistoryIcon(),
              _emptyHistoryDescription(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyHistoryIcon() {
    return Icon(
      Icons.shopping_basket_outlined,
      size: 100,
      color: shadesThree,
    );
  }

  Widget _emptyHistoryDescription() {
    return Text(
      "Brak produktów \nw koszyku",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: shadesThree,
        fontSize: 25,
      ),
    );
  }
}
