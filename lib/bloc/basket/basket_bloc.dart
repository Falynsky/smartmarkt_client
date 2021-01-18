import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(InitialState());

  @override
  Stream<BasketState> mapEventToState(BasketEvent event) {
    throw UnimplementedError();
  }
}
