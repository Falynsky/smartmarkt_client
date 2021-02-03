import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class SignUpTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Text(
        'REJESTRACJA',
        style: TextStyle(
          shadows: <Shadow>[
            Shadow(
              offset: Offset(5, 5),
              blurRadius: 8.0,
              color: Colors.black12,
            ),
          ],
          color: complementaryOne,
          fontFamily: 'OpenSans',
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
