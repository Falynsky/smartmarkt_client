import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class SignUpBackButton extends StatefulWidget {
  @override
  _SignUpBackButtonState createState() => _SignUpBackButtonState();
}

class _SignUpBackButtonState extends State<SignUpBackButton> {
  late RouteBloc _routeBloc;

  @override
  void initState() {
    super.initState();

    _routeBloc = BlocProvider.of<RouteBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBackButton();
  }

  Widget _buildBackButton() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () => _routeBloc.add(LoadLoginPageEvent()),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
            'POWRÓT',
            style: TextStyle(
              color: secondaryColor,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }
}
