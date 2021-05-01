import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpLoadingEvent extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class LoadedSignUpEvent extends SignUpEvent {
  @override
  List<Object> get props => [];
}

class RegisterAccountEvent extends SignUpEvent {
  final String mail;
  final String login;
  final String password;
  final String firstName;
  final String lastName;

  RegisterAccountEvent({
    required this.mail,
    required this.login,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object> get props => [
        mail,
        login,
        password,
        firstName,
        lastName,
      ];
}
