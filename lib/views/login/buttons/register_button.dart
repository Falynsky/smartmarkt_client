import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class RegisterButton extends StatefulWidget {
  @override
  _RegisterButtonState createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
 late RouteBloc _routeBloc;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return _signUpButton();
  }

  Widget _signUpButton() {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 15, right: 15),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _onButtonPress,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: _buttonLabel(),
      ),
    );
  }

  void _onButtonPress() {
    Key key = UniqueKey();
    _routeBloc.add(SignUpPageEvent(key));
  }

  Widget _buttonLabel() {
    return Text(
      'NOWE KONTO',
      style: TextStyle(
        color: secondaryColor,
        letterSpacing: 1.5,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    );
  }
}
