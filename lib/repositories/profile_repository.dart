import 'package:flutter/material.dart';
import 'package:smartmarktclient/providers/profile_provider.dart';

class ProfileRepository {
  ProfileProvider _profileProvider;

  ProfileRepository() {
    _profileProvider = ProfileProvider();
  }

  Future<Map<String, dynamic>> getProfileInfo() async {
    return await _profileProvider.getProfileInfo();
  }

  Future<Map<String, dynamic>> loadBasketHistoryInfo(
      {@required String userId}) async {
    return await _profileProvider.loadBasketHistoryInfo(userId: userId);
  }
}
