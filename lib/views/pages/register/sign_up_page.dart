import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/text_field_component.dart';
import 'package:smartmarktclient/http/http_service.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  RouteBloc _routeBloc;
  final login = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();

  @override
  void initState() {
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _routeBloc.add(LoadLoginPageEvent());
        return false;
      },
      child: Scaffold(
        body: _buildGestureDetector(context),
      ),
    );
  }

  GestureDetector _buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          buildBackground(),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildSignUpTitle(),
                  TextFieldComponent(
                    controller: login,
                    label: 'Login',
                    placeHolder: 'Login',
                    icon: Icons.person,
                    isRequired: false,
                  ),
                  TextFieldComponent(
                    controller: password,
                    label: 'Hasło',
                    placeHolder: 'Hasło',
                    icon: Icons.lock,
                    isRequired: false,
                  ),
                  TextFieldComponent(
                    controller: firstName,
                    label: 'Imię',
                    placeHolder: 'Imię',
                    icon: Icons.person,
                    isRequired: false,
                  ),
                  TextFieldComponent(
                    controller: lastName,
                    label: 'Nazwisko',
                    placeHolder: 'Nazwisko',
                    icon: Icons.person,
                    isRequired: false,
                  ),
                  Row(
                    children: [
                      Flexible(child: _buildBackBtn()),
                      Flexible(child: _buildSignUpBtn()),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSignUpTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: Text(
        'REJESTRACJA',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container buildBackground() {
    var gradientColors = [
      Color(0xFF8eebe4),
      Color(0xFF48dbcf),
      Color(0xFF40c5ba),
      Color(0xFF31b9ae),
    ];
    var gradientColorsStops = [0.1, 0.4, 0.7, 0.9];
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
          stops: gradientColorsStops,
        ),
      ),
    );
  }

  Widget _buildSignUpBtn() {
    return Container(
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
            color: Color(0xFF24756f),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  void _signUpButton() async {
    String _login = login.text.toString();
    String _password = password.text.toString();
    String _firstName = firstName.text.toString();
    String _lastName = lastName.text.toString();
    Map<String, dynamic> body = {
      "username": _login,
      "password": _password,
      "firstName": _firstName,
      "lastName": _lastName,
      "licenceKey": "__________"
    };

    HttpService httpService = HttpService();
    var response = await httpService.post(
      url: '/signUp/register',
      body: body,
    );

    if (response['success']) {
      setState(() {
        _routeBloc.add(LoadLoginPageEvent());
      });
    } else {
      _showMyDialog('Błąd rejestracji',
          'Wystąpił problem w trakcie rejestracji, sprawdź wprowadzone wartości i spróbuj ponownie');
    }
  }

  Widget _buildBackBtn() {
    return Container(
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
            color: Color(0xFF24756f),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String title, String body) async {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(90.0)),
          ),
          child: AlertDialog(
            title: Text(title),
            titleTextStyle: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(body),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                textColor: Colors.blueAccent,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
