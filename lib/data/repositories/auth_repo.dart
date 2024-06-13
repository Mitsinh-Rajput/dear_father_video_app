import 'dart:developer';

import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/constants.dart';
import '../api/api_client.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final ApiClient apiClient;

  AuthRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> submitDa(FormData form) async => await apiClient.postData(AppConstants.submitDa, form);

  /// Methods to deal with Local Data ///
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.token, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  Future<bool> saveUserId(String id) async {
    log(getUserId());
    return await sharedPreferences.setString(AppConstants.userId, id);
  }

  String getUserId() {
    return sharedPreferences.getString(AppConstants.userId) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.token);
    sharedPreferences.remove(AppConstants.userId);
    apiClient.token = null;
    apiClient.updateHeader(null);
    return true;
  }

  /// Methods to deal with Local Data ///
}
