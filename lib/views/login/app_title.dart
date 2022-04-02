import 'package:flutter/material.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'SmartMarkt',
        style: _appTitleStyle(),
      ),
    );
  }

  TextStyle _appTitleStyle() {
    return TextStyle(
      shadows: <Shadow>[
        Shadow(
          offset: Offset(5, 5),
          blurRadius: 8.0,
          color: Colors.black12,
        ),
      ],
      color: complementaryOne,
      fontFamily: 'OpenSans',
      fontSize: 45,
      fontWeight: FontWeight.bold,
    );
  }
}
