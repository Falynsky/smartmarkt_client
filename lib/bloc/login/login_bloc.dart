import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/bloc.dart';
import 'package:smartmarktclient/repositories/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository _loginRepository;

  LoginBloc() : super(LoginLoadingState()) {
    _loginRepository = LoginRepository();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginLoadingEvent) {
      yield LoginLoadingState();
      Future.delayed(Duration(milliseconds: 10), () {
        final loadedLoginEvent = LoadedLoginEvent();
        add(loadedLoginEvent);
      });
    } else if (event is LoadedLoginEvent) {
      yield LoadedLoginState();
    } else if (event is LoginAccountEvent) {
      yield* _loginToSystem(event);
    }
  }

  Stream<LoginState> _loginToSystem(LoginAccountEvent event) async* {
    Map<String, dynamic> response = await _loginRepository.login(
      login: event.login,
      password: event.password,
    );

    if (response['success']) {
      yield CorrectLoginState(key: UniqueKey());
    } else {
      Map<String, dynamic> data = response['data'];
      String title = data['title'] ?? 'Błąd logowania';
      String msg = data['msg'] ?? 'Niepoprawne dane.';

      yield LoginErrorOccurredState(
        title: title,
        msg: msg,
        key: UniqueKey(),
      );
    }
  }
}
