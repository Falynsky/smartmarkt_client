import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class InitialProfileEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class LoadBasketHistoryEvent extends ProfileEvent {
  @override
  List<Object> get props => [];
}

class ShowBasketHistoryDialogEvent extends ProfileEvent {
  final int basketHistoryId;
  final String purchasedDate;
  final String productSummary;

  ShowBasketHistoryDialogEvent({
    required this.basketHistoryId,
    required this.purchasedDate,
    required this.productSummary,
  });

  @override
  List<Object> get props => [
        basketHistoryId,
        purchasedDate,
        productSummary,
      ];
}
