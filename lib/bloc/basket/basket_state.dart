import 'package:equatable/equatable.dart';

abstract class BasketState extends Equatable {
  const BasketState();
}

class InitialState extends BasketState {
  @override
  List<Object> get props => [];
}
