import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartmarktclient/bloc/profile/profile_event.dart';
import 'package:smartmarktclient/bloc/profile/profile_state.dart';
import 'package:smartmarktclient/models/basket_history.dart';
import 'package:smartmarktclient/models/product_history.dart';
import 'package:smartmarktclient/repositories/profile_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository _profileRepository;

  ProfileBloc() : super(InitialProfileState()) {
    _profileRepository = ProfileRepository();
  }

  String name;
  String initials;
  String userId;
  List<BasketHistory> _basketHistory;

  List<BasketHistory> get basketHistory => _basketHistory;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is InitialProfileEvent) {
      Map<String, dynamic> response = await _profileRepository.getProfileInfo();
      if (response['success']) {
        Map<String, dynamic> data = response['data'];
        String firstName = data['firstName'];
        String lastName = data['lastName'];
        name = '$firstName $lastName';
        initials = firstName[0] + lastName[0];
        userId = data['userId'].toString();
        add(LoadBasketHistoryEvent());
      } else {}
    } else if (event is LoadBasketHistoryEvent) {
      Map<String, dynamic> response =
          await _profileRepository.loadBasketHistoryInfo(userId: userId);
      if (response['success']) {
        _basketHistory = [];
        final basketHistory =
            List<Map<String, dynamic>>.from(response['data']['historyList']);
        basketHistory.forEach((jsonBasketHistory) {
          BasketHistory basketHistory =
              BasketHistory.fromJson(jsonBasketHistory);
          _basketHistory.add(basketHistory);
        });
        yield LoadProfileScreenState();
      } else {}
    } else if (event is ShowBasketHistoryDialogEvent) {
      int basketHistoryId = event.basketHistoryId;
      Map<String, dynamic> response =
          await _profileRepository.loadSelectedBasketHistoryInfo(
        userId: userId,
        basketHistoryId: basketHistoryId,
      );
      if (response['success']) {
        final productsList =
            List<Map<String, dynamic>>.from(response['data']['productsList']);
        List<ProductHistory> objectedProductList = [];
        productsList.forEach((jsonProductsList) {
          ProductHistory productsList =
              ProductHistory.fromJson(jsonProductsList);
          objectedProductList.add(productsList);
        });
        Key key = UniqueKey();
        yield ShowBasketHistoryDialogState(
          key: key,
          productsList: objectedProductList,
          purchasedDate: event.purchasedDate,
          productSummary: event.productSummary,
        );
      } else {}
    }
  }
}
