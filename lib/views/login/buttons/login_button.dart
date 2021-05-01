import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final GlobalKey<FormState>  formKey;

  const LoginButton({
    required this.loginController,
    required this.formKey,
    required this.passwordController,
  });

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
 late LoginBloc _loginBloc;
 late TextEditingController _loginController;
 late TextEditingController _passwordController;
 late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginController = widget.loginController;
    _passwordController = widget.passwordController;
    _formKey = widget.formKey;
  }

  @override
  Widget build(BuildContext context) {
    return _loginButton();
  }

  Widget _loginButton() {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 15, right: 15),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _buttonOnPress,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: _buttonLabel(),
      ),
    );
  }

  void _buttonOnPress() async {
    bool validate = _formKey.currentState?.validate() ?? false;
    if (validate) {
      String _login = _loginController.text.toString();
      String _password = _passwordController.text.toString();
      final loginAccountEvent = LoginAccountEvent(
        login: _login,
        password: _password,
      );

      _loginBloc.add(loginAccountEvent);
    }
  }

  Widget _buttonLabel() {
    return Text(
      'ZALOGUJ',
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
