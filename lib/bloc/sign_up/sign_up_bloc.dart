import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/repositories/sign_up_repository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  late SignUpRepository _signUpRepository;

  SignUpBloc() : super(SignUpLoadingState()) {
    _signUpRepository = SignUpRepository();
  }

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpLoadingEvent) {
      yield SignUpLoadingState();
      Future.delayed(
        Duration(milliseconds: 10),
        _emitLoadedSignUpEvent,
      );
    } else if (event is LoadedSignUpEvent) {
      yield LoadedSignUpState();
    } else if (event is RegisterAccountEvent) {
      yield* _registerAccount(event);
    }
  }

  FutureOr<dynamic> _emitLoadedSignUpEvent() {
    final loadedSignUpEvent = LoadedSignUpEvent();
    add(loadedSignUpEvent);
  }

  Stream<SignUpState> _registerAccount(RegisterAccountEvent event) async* {
    Map<String, dynamic> response = await _signUpRepository.register(
      mail: event.mail,
      login: event.login,
      password: event.password,
      firstName: event.firstName,
      lastName: event.lastName,
    );

    if (response['success']) {
      yield CorrectRegisterState();
    } else {
      Map<String, dynamic> data = response['data'];
      String title = data['title'] ?? 'Błąd rejestracji';
      String msg =
          data['msg'] ?? 'Sprawdź wprowadzone wartości i spróbuj ponownie';

      yield RegisterErrorOccurredState(
        title: title,
        msg: msg,
        key: GlobalKey(),
      );
    }
  }
}
