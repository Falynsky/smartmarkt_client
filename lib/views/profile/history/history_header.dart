import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class HistoryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: shadesTwo,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Historia zakupów",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: complementaryTwo,
            ),
          ),
        ],
      ),
    );
  }
}
