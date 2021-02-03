import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class EmptyScannerResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 90,
            color: complementaryThree,
          ),
          Text(
            "Nie znaleziono \nproduktu",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: complementaryThree,
            ),
          ),
        ],
      ),
    );
  }
}
