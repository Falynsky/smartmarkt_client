import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/bloc/sign_up/sign_up_event.dart';
import 'package:smartmarktclient/utilities/colors.dart';

class SignUpButton extends StatefulWidget {
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController mailController;
  final GlobalKey<FormState> formKey;

  const SignUpButton({
    required this.loginController,
    required this.passwordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.mailController,
    required this.formKey,
  });

  @override
  _SignUpButtonState createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
late TextEditingController _loginController;
late TextEditingController _passwordController;
late TextEditingController _firstNameController;
late TextEditingController _lastNameController;
late TextEditingController _mailController;
late GlobalKey<FormState> _formKey;
late SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    _loginController = widget.loginController;
    _passwordController = widget.passwordController;
    _firstNameController = widget.firstNameController;
    _lastNameController = widget.lastNameController;
    _mailController = widget.mailController;
    _formKey = widget.formKey;
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return _buildSignUpButton();
  }

  Widget _buildSignUpButton() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: _signUpButton,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
            'ZAPISZ',
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

  void _signUpButton() async {
    bool validate = _formKey.currentState?.validate() ?? false;
    if (validate) {
      String _mail = _mailController.text.toString();
      String _login = _loginController.text.toString();
      String _password = _passwordController.text.toString();
      String _firstName = _firstNameController.text.toString();
      String _lastName = _lastNameController.text.toString();

      final registerAccountEvent = RegisterAccountEvent(
        mail: _mail,
        login: _login,
        password: _password,
        firstName: _firstName,
        lastName: _lastName,
      );

      _signUpBloc.add(registerAccountEvent);
    }
  }
}
