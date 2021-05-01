import 'package:smartmarktclient/providers/profile_provider.dart';

class ProfileRepository {
  late ProfileProvider _profileProvider;

  ProfileRepository() {
    _profileProvider = ProfileProvider();
  }

  Future<Map<String, dynamic>> getProfileInfo() async {
    return await _profileProvider.getProfileInfo();
  }

  Future<Map<String, dynamic>> loadBasketHistoryInfo({required String userId}) async {
    return await _profileProvider.loadBasketHistoryInfo(userId: userId);
  }

  Future<Map<String, dynamic>> loadSelectedBasketHistoryInfo({
    required String userId,
    required int basketHistoryId,
  }) async {
    return await _profileProvider.loadSelectedBasketHistoryInfo(
        userId: userId, basketHistoryId: basketHistoryId);
  }
}
