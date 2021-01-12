import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/text_field_component.dart';
import 'package:smartmarktclient/utilities/circular_idicator.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  RouteBloc _routeBloc;
  SignUpBloc _signUpBloc;
  bool _isLoading;

  final login = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _routeBloc = BlocProvider.of<RouteBloc>(context);
    _signUpBloc = SignUpBloc();
    _signUpBloc.add(SignUpLoadingEvent());
    _isLoading = true;
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
        body: BlocProvider(
          create: (_) => _signUpBloc,
          child: BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpLoadingState) {
                  _isLoading = true;
                } else if (state is LoadedSignUpState) {
                  _isLoading = false;
                } else if (state is RegisterErrorOccurredState) {
                  _showMyDialog(state.title, state.msg);
                } else if (state is CorrectRegisterState) {
                  _routeBloc.add(LoadLoginPageEvent());
                }
                setState(() {});
              },
              child: _signUpPage(context)),
        ),
      ),
    );
  }

  Widget _signUpPage(BuildContext context) {
    if (_isLoading) {
      return CircularIndicator();
    }

    return _registerForm(context);
  }

  Widget _registerForm(BuildContext context) {
    return GestureDetector(
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
                    _signUpTitle(),
                    _loginField(),
                    _passwordField(),
                    _firstNameField(),
                    _lastNameField(),
                    _buttons(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _signUpTitle() {
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

  Widget _loginField() {
    return TextFieldComponent(
      controller: login,
      label: 'Login',
      placeHolder: 'Login',
      icon: Icons.person,
      isRequired: true,
    );
  }

  Widget _passwordField() {
    return TextFieldComponent(
      controller: password,
      label: 'Hasło',
      placeHolder: 'Hasło',
      icon: Icons.lock,
      isRequired: true,
    );
  }

  Widget _firstNameField() {
    return TextFieldComponent(
      controller: firstName,
      label: 'Imię',
      placeHolder: 'Imię',
      icon: Icons.person,
      isRequired: true,
    );
  }

  Widget _lastNameField() {
    return TextFieldComponent(
      controller: lastName,
      label: 'Nazwisko',
      placeHolder: 'Nazwisko',
      icon: Icons.person,
      isRequired: true,
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        Flexible(child: _buildBackButton()),
        Flexible(child: _buildSignUpButton()),
      ],
    );
  }

  Container buildBackground() {
    List<Color> gradientColors = [
      Color(0xFF8eebe4),
      Color(0xFF48dbcf),
      Color(0xFF40c5ba),
      Color(0xFF31b9ae),
    ];
    List<double> gradientColorsStops = [0.1, 0.4, 0.7, 0.9];
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

  Widget _buildSignUpButton() {
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
    bool validate = _formKey.currentState.validate();
    if (validate) {
      String _login = login.text.toString();
      String _password = password.text.toString();
      String _firstName = firstName.text.toString();
      String _lastName = lastName.text.toString();

      final registerAccountEvent = RegisterAccountEvent(
        login: _login,
        password: _password,
        firstName: _firstName,
        lastName: _lastName,
      );

      _signUpBloc.add(registerAccountEvent);
    }
  }

  Widget _buildBackButton() {
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

  void _showMyDialog(String title, String body) async {
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

  @override
  void dispose() {
    super.dispose();
    _signUpBloc.close();
  }
}
