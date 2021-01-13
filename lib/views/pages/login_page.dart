import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/text_field_component.dart';
import 'package:smartmarktclient/utilities/circular_idicator.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/utilities/gradient.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  RouteBloc _routeBloc;
  LoginBloc _loginBloc;
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _loginBloc = LoginBloc();
    _loginBloc.add(LoginLoadingEvent());
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _loginBloc,
        child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginLoadingState) {
                _isLoading = true;
              } else if (state is LoadedLoginState) {
                _isLoading = false;
              } else if (state is LoginErrorOccurredState) {
                _showMyDialog(state.title, state.msg);
              } else if (state is CorrectLoginState) {
                _routeBloc.add(LoadMainMenuEvent());
              }
              setState(() {});
            },
            child: _loginPage(context)),
      ),
    );
  }

  Widget _loginPage(BuildContext context) {
    if (_isLoading) {
      return CircularIndicator();
    }
    return _loginForm(context);
  }

  GestureDetector _loginForm(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          gradientBackground(),
          Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _appNameTitle(),
                    _loginField(),
                    _passwordField(),
                    _loginButon(),
                    _signUpButton(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _appNameTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'SmartMarkt',
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
          fontSize: 45,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _loginField() {
    return TextFieldComponent(
      controller: _loginController,
      label: 'Login',
      placeHolder: 'Wprowadź login',
      icon: Icons.person,
      isRequired: true,
    );
  }

  Widget _passwordField() {
    return TextFieldComponent(
      controller: _passwordController,
      label: 'Hasło',
      placeHolder: 'Wprowadź hasło',
      icon: Icons.lock,
      isRequired: true,
    );
  }

  Widget _loginButon() {
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
            color: secondaryColor,
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
    bool validate = _formKey.currentState.validate();
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

  //todo: do ogarnięcia klasa pozwalajaca na tworzenie dialogu poprzez jej wywołanie a nie powtarzanie kodu
  Widget _signUpButton() {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 15, right: 15),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => {_routeBloc.add(SignUpPageEvent())},
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'NOWE KONTO',
          style: TextStyle(
            color: secondaryColor,
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
