import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import '../../controllers/auth_controller.dart';
import '../../main.dart';
import '../../services/constants.dart';
import '../../services/route_helper.dart';
import '../../views/screens/splash_screen/splash_screen.dart';
import '../repositories/auth_repo.dart';

class ApiCalls {
  String? token;
  Map<String, String>? mainHeaders;

  validCall(int status) {
    return [200, 422, 201].contains(status);
  }

  apiHandler(http.Response res, url) {
    if (res.statusCode == 401 || res.statusCode == 429) {
      getx.Get.find<AuthController>().clearSharedData();
      navigatorKey.currentState!.pushAndRemoveUntil(
          getCustomRoute(child: const SplashScreen()), (route) => false);
    }
    if (kDebugMode) {
      apiToasts(res, url: url);
    }
  }

  apiToasts(http.Response res, {url}) {
    Fluttertoast.cancel();
    try {
      if ((jsonDecode(res.body) as Map).containsKey('message')) {
        showCustomToast("${jsonDecode(res.body)['message']}",
            color: url == null ? null : Colors.red);
        log("${jsonDecode(res.body)['message']}",
            name:
                "${DateTime.now().toString().split(' ')[1]}->HANDLERS->${url ?? ""}");
      } else if ((jsonDecode(res.body) as Map).containsKey('msg')) {
        showCustomToast("${jsonDecode(res.body)['msg']}",
            color: url == null ? null : Colors.red);

        log("${jsonDecode(res.body)['msg']}",
            name:
                "${DateTime.now().toString().split(' ')[1]}->HANDLERS->${url ?? ""}");
      } else if ((jsonDecode(res.body) as Map).containsKey('error')) {
        showCustomToast("${jsonDecode(res.body)['error']}",
            color: url == null ? null : Colors.red);
        log("${jsonDecode(res.body)['error']}",
            name:
                "${DateTime.now().toString().split(' ')[1]}->HANDLERS->${url ?? ""}");
      }
    } catch (e) {
      log('$e', name: "ERROR AT API HANDLER");
    }
  }

  showResponse(
    http.Response response,
    Map<String, dynamic>? postBody,
    String url,
    token,
  ) {
    log("TYPE : ${postBody == null ? "GET" : "POST ${DateTime.now().toString().split(' ')[1]}"}\nURL : $url\nTOKEN : $token\nPOSTBODY : $postBody\nRESPONSE CODE : ${response.statusCode}\nRESPONSE : ${response.body}\n",
        name: "API CALL");
  }

  Future<dynamic> apiCallWithResponsePost(
      String extUrl, Map<String, dynamic> body) async {
    mainHeaders = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${token = (getx.Get.find<AuthRepo>().getUserToken())}',
    };
    var url = AppConstants.baseUrl + extUrl;
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: body,
        headers: mainHeaders,
      );
      showResponse(response, body, url, token);
      apiHandler(response, extUrl);
      if (validCall(response.statusCode)) {
        return (response);
      } else {
        return "failed";
      }
    } catch (e) {
      log('$url -Error catching data', name: e.toString());
      Fluttertoast.showToast(msg: "Something went wrong !! ");
      return "failed";
    }
  }

  Future<dynamic> apiCallWithResponseGet(String extUrl) async {
    mainHeaders = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer ${token = (getx.Get.find<AuthRepo>().getUserToken())}',
    };
    var url = AppConstants.baseUrl + extUrl;
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: mainHeaders,
      );
      apiHandler(response, extUrl);
      showResponse(response, null, url, token);
      if (validCall(response.statusCode)) {
        return (response);
      } else {
        return "failed";
      }
    } catch (e) {
      log('$url -Error catching data', name: e.toString());
      Fluttertoast.showToast(msg: "Something went wrong !! ");
      return "failed";
    }
  }
}
