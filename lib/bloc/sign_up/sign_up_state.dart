import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpLoadingState extends SignUpState {
  @override
  List<Object> get props => [];
}

class LoadedSignUpState extends SignUpState {
  @override
  List<Object> get props => [];
}

class CorrectRegisterState extends SignUpState {
  @override
  List<Object> get props => [];
}

class RegisterErrorOccurredState extends SignUpState {
  final String title;
  final String msg;

  RegisterErrorOccurredState({
    this.title,
    this.msg,
  });

  @override
  List<Object> get props => [
        title,
        msg,
      ];
}
