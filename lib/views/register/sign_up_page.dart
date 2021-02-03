import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/components/text_field_component.dart';
import 'package:smartmarktclient/utilities/circular_idicator.dart';
import 'package:smartmarktclient/utilities/colors.dart';
import 'package:smartmarktclient/utilities/gradient.dart';
import 'package:smartmarktclient/views/register/sign_up_back_button.dart';
import 'package:smartmarktclient/views/register/sign_up_button.dart';
import 'package:smartmarktclient/views/register/sign_up_title.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  RouteBloc _routeBloc;
  SignUpBloc _signUpBloc;
  bool _isLoading;

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mailController = TextEditingController();
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
        children: <Widget>[gradientBackground(), _signUpForm()],
      ),
    );
  }

  Widget _signUpForm() {
    return Form(
      key: _formKey,
      child: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _signUpTitle(),
              _mailField(),
              _loginField(),
              _passwordField(),
              _firstNameField(),
              _lastNameField(),
              _buttons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpTitle() {
    return SignUpTitle();
  }

  Widget _mailField() {
    return TextFieldComponent(
      controller: _mailController,
      label: 'E-mail',
      placeHolder: 'E-mail',
      icon: Icons.local_post_office_rounded,
      isRequired: true,
      isMail: true,
      autoValidate: false,
    );
  }

  Widget _loginField() {
    return TextFieldComponent(
      controller: _loginController,
      label: 'Login',
      placeHolder: 'Login',
      icon: Icons.person,
      isRequired: true,
    );
  }

  Widget _passwordField() {
    return TextFieldComponent(
      controller: _passwordController,
      label: 'Hasło',
      placeHolder: 'Hasło',
      icon: Icons.lock,
      isRequired: true,
      obscureText: true,
    );
  }

  Widget _firstNameField() {
    return TextFieldComponent(
      controller: _firstNameController,
      label: 'Imię',
      placeHolder: 'Imię',
      icon: Icons.person,
      isRequired: true,
    );
  }

  Widget _lastNameField() {
    return TextFieldComponent(
      controller: _lastNameController,
      label: 'Nazwisko',
      placeHolder: 'Nazwisko',
      icon: Icons.person,
      isRequired: true,
    );
  }

  Widget _buttons() {
    return Row(
      children: [
        _buildBackButton(),
        _buildSignUpButton(),
      ],
    );
  }

  Widget _buildBackButton() {
    return SignUpBackButton();
  }

  Widget _buildSignUpButton() {
    return SignUpButton(
      loginController: _loginController,
      passwordController: _passwordController,
      firstNameController: _firstNameController,
      lastNameController: _lastNameController,
      mailController: _mailController,
      formKey: _formKey,
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
                child: Text('OK'),
                textColor: complementaryThree,
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
