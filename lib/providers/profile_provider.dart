import 'package:flutter/cupertino.dart';
import 'package:smartmarktclient/http/http_service.dart';

class ProfileProvider {
  HttpService _httpService;
  final String _profileEndPoint = "/profile";
  final String _historyEndPoint = "/history";

  ProfileProvider() {
    _httpService = HttpService();
  }

  Future<Map<String, dynamic>> getProfileInfo() async {
    String url = "$_profileEndPoint/getInfo";
    Map<String, dynamic> response = await _httpService.get(url: url);
    return response;
  }

  Future<Map<String, dynamic>> loadBasketHistoryInfo(
      {@required String userId}) async {
    String url = "$_historyEndPoint/user/$userId";
    Map<String, dynamic> response = await _httpService.get(url: url);
    return response;
  }

  Future<Map<String, dynamic>> loadSelectedBasketHistoryInfo({
    @required String userId,
    @required int basketHistoryId,
  }) async {
    String url = "$_historyEndPoint/$userId/$basketHistoryId";
    Map<String, dynamic> response = await _httpService.get(url: url);
    return response;
  }
}
