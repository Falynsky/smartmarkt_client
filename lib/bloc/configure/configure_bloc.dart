import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class ConfigureBloc extends Bloc<ConfigureEvent, ConfigureState> {
  ConfigureBloc() : super(LoadConfigureMenuState());

  @override
  Stream<ConfigureState> mapEventToState(
    ConfigureEvent event,
  ) async* {
    if (event is LoadConfigurePageEvent) {
      yield LoadConfigureMenuState();
    }
  }
}
