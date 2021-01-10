import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/text_field_component.dart';
import 'package:smartmarktclient/http/http_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  RouteBloc _routeBloc;
  final login = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[
            buildBackground(),
            Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildSignInTitle(),
                      TextFieldComponent(
                        controller: login,
                        label: 'Login',
                        placeHolder: 'Wprowadź login',
                        icon: Icons.person,
                        isRequired: true,
                      ),
                      TextFieldComponent(
                        controller: password,
                        label: 'Hasło',
                        placeHolder: 'Wprowadź hasło',
                        icon: Icons.lock,
                        isRequired: true,
                      ),
                      _buildLoginBtn(),
                      _buildSignUpBtn(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSignInTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'SmartMarkt',
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
    final gradientColorsStops = [0.1, 0.4, 0.7, 0.9];
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

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 15, right: 15),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _loginButton,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'ZALOGUJ',
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

  void _loginButton() async {
    var validate = _formKey.currentState.validate();
    if (validate) {
      String _login = login.text.toString();
      String _password = password.text.toString();
      Map<String, dynamic> body = {
        'username': _login,
        'password': _password,
      };

      HttpService httpService = HttpService();
      var response = await httpService.post(
        url: '/auth/login',
        body: body,
      );

      if (response['success']) {
        setState(() {
          _routeBloc.add(LoadMainMenuEvent());
        });
      } else {
        _showMyDialog('Błąd logowania', 'Niepoprawne dane.');
      }
    }
  }

  Widget _buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 15, right: 15),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: emitSignUpEvent,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'NOWE KONTO',
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

  void emitSignUpEvent() async {
    _routeBloc.add(SignUpPageEvent());
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
