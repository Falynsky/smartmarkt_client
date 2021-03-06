import 'package:flutter/material.dart';
import 'package:smartmarktclient/models/product.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class ProductInfoDialog {
  void showDialogBox(
    BuildContext context,
    Product product,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: shadesThree,
          titleTextStyle: TextStyle(color: complementaryThree, fontSize: 20),
          title: Text(product.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(product.productInfo),
              ],
            ),
          ),
          contentTextStyle: TextStyle(color: Colors.white70, fontSize: 16),
          actions: <Widget>[
            _closeButton(context),
          ],
        );
      },
    );
  }

  FlatButton _closeButton(BuildContext context) {
    return FlatButton(
      child: Text("Zamknij"),
      textColor: complementaryThree,
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
