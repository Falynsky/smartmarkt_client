import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/text_field_component.dart';
import 'package:smartmarktclient/utilities/circular_idicator.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/utilities/gradient.dart';
import 'package:smartmarktclient/views/login/app_title.dart';
import 'package:smartmarktclient/views/login/buttons/login_button.dart';
import 'package:smartmarktclient/views/login/buttons/register_button.dart';

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

  Widget _loginForm(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _routeBloc.add(ConfigurePageEvent());
        return false;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: <Widget>[gradientBackground(), _loginPageForm()],
        ),
      ),
    );
  }

  Widget _loginPageForm() {
    return Form(
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
              _loginButton(),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appNameTitle() {
    return AppTitle();
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
      obscureText: true,
    );
  }

  Widget _loginButton() {
    return LoginButton(
      formKey: _formKey,
      loginController: _loginController,
      passwordController: _passwordController,
    );
  }

  Widget _registerButton() {
    return RegisterButton();
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
            backgroundColor: shadesThree,
            title: Text(title),
            titleTextStyle: TextStyle(color: complementaryThree, fontSize: 20),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(body),
                ],
              ),
            ),
            contentTextStyle: TextStyle(color: Colors.white70, fontSize: 16),
            actions: <Widget>[
              FlatButton(
                textColor: complementaryThree,
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }
}
