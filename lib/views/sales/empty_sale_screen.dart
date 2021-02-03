import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class EmptySaleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.format_list_bulleted_rounded,
              size: 100,
              color: shadesThree,
            ),
            Text(
              "Brak promocji",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: shadesThree,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
