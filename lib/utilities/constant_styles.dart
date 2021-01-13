import 'package:flutter/material.dart';

final hintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final labelStyle = TextStyle(
  color: Color(0xFF84B389),
  fontSize: 15,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final focusedBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: BorderSide(
    color: Color(0xFF306c63),
    width: 2.0,
  ),
);

final enabledBorderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5.0),
  borderSide: BorderSide(
    color: Colors.white54,
    width: 1.0,
  ),
);

final errorMessageStyle = TextStyle(color: Color(0xFFE10000), fontSize: 14);

final inputErrorBorderStyle = OutlineInputBorder(
  borderSide: new BorderSide(color: Color(0xFFE10000), width: 2.0),
);
