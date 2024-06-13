import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/contact_number.dart';
import '../data/models/response/response_model.dart';
import '../data/models/response/user_model.dart';
import '../data/repositories/auth_repo.dart';
import '../generated/assets.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool _acceptTerms = true;

  late final number = ContactNumber(number: '', countryCode: '+91');

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  bool get isLoading => _isLoading;

  bool get acceptTerms => _acceptTerms;
  PageController pageController = PageController();

  int index = 0;

  Map<String, dynamic> data = {
    "se_name": null,
    "hq": null,
    "dr_name": null,
    "city": null,
    "comment": null,
  };
  TextEditingController oneController = TextEditingController();
  TextEditingController twoController = TextEditingController();
  TextEditingController threeController = TextEditingController();
  TextEditingController fourController = TextEditingController();
  TextEditingController comments = TextEditingController();
  TextEditingController QuestionThirdAnswerForOther = TextEditingController();

  final FocusNode focusNode = FocusNode();

  late AnimationController controller;

  List QuestionOneOption = [
    "<5",
    "Between 5-10 pts",
    "Between 10-15 pts",
    "Between 15-20 pts",
    ">20 pts",
  ];

  List QuestionSecondOption = [
    "Technology",
    "Comfort",
    "Mileage",
  ];

  List QuestionThirdOption = ["Plain Alpha blocker", "Tamsulosin + Deflazacort", "NSAIDs", "Others (Pls specify)"];

  List QuestionFourthOption = ["Yes", "No"];
  List QuestionFifthOption = ["Efficacy", "Safety"];
  List QuestionSixOption = [
    "7 days",
    "10 days",
    "15 days",
    ">15 days",
  ];
  TextEditingController QuestionSecondAnswer = TextEditingController();
  TextEditingController QuestionSevenAnswer = TextEditingController();
  String QuestionThirdAnswer = "";
  String QuestionOneAnswer = "";
  String QuestionfourthAnswer = "";
  String QuestionfifthAnswer = "";
  String QuestionSixAnswer = "";
  List QuestionfifthValues = [null, null];

  // List<bool> QuestionOneCheckBox = [false, false, false];
  List<bool> QuestionTwoCheckBox = [false, false, false];
  List<bool> QuestionThreeCheckBox = [false, false, false];

  List<String> images = [
    Assets.images2D,
    Assets.imagesBG,
  ];

  Future<bool> connectivity() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        log('connected');

        return true;
      }
    } on SocketException catch (_) {
      log('not connected');
      return false;
    }
    return false;
  }

  forwardButton() async {
    focusNode.unfocus();
    if (pageController.page! < images.length) {
      if (pageController.page! == 4) {
        pageController.jumpToPage(5);
        update();
      } else if (pageController.page! == images.length - 1) {
        submitForm();
        // await pageController.animateToPage(0, duration: const Duration(milliseconds: 50), curve: Curves.ease);
        // update();
      } else {
        await pageController.animateToPage((pageController.page! + 1).round(), duration: const Duration(milliseconds: 50), curve: Curves.ease);
        update();
      }
    }
  }

  resetForm() async {
    await pageController.animateToPage(0, duration: const Duration(milliseconds: 50), curve: Curves.ease);
    oneController.clear();
    twoController.clear();
    threeController.clear();
    fourController.clear();
    comments.clear();

    QuestionOneAnswer = "";
    QuestionSecondAnswer.clear();
    QuestionThirdAnswer = "";
    QuestionfourthAnswer = "";
    QuestionfifthAnswer = "";
    QuestionSixAnswer = "";
    QuestionSevenAnswer.clear();
    await pageController.animateToPage(0, duration: const Duration(milliseconds: 50), curve: Curves.ease);
    update();
  }

  submitForm() async {
    data['se_name'] = oneController.text;
    data['dr_name'] = twoController.text;
    data['hq'] = threeController.text;
    data['city'] = fourController.text;
    data['question_1'] = comments.text;

    if (await connectivity()) {
      //API CALL
      log(
        "$data",
        name: "DATA",
      );
      submitDa(data).then((value) {
        if (value.isSuccess) {
          resetForm();
          controller.forward(from: 0);
          Fluttertoast.showToast(msg: "Data saved to server");
        } else {
          SharedPreferences sharedPreferences = Get.find();
          sharedPreferences.clear();
          log('${sharedPreferences.getString('saved_data')}');
          List<dynamic> savedData = jsonDecode(sharedPreferences.getString('saved_data') ?? '[]');
          savedData.add(data);
          sharedPreferences.setString('saved_data', jsonEncode(savedData));
          resetForm();
          controller.forward(from: 0).then((value) {
            syncData();
          });
          Fluttertoast.showToast(msg: "Data saved locally");
        }
      });
    } else {
      SharedPreferences sharedPreferences = Get.find();
      List<dynamic> savedData = jsonDecode(sharedPreferences.getString('saved_data') ?? '[]');
      savedData.add(data);
      sharedPreferences.setString('saved_data', jsonEncode(savedData));
      Fluttertoast.showToast(msg: "Data saved locally");
      resetForm();
      controller.forward(from: 0).then((value) {
        syncData();
      });
    }
  }

  Future<ResponseModel> submitDa(data) async {
    ResponseModel responseModel;
    _isLoading = true;
    update();
    try {
      Response response = await authRepo.submitDa(FormData(data));
      log(response.bodyString.toString(), name: 'submitDa()');
      if (response.statusCode == 200) {
        responseModel = ResponseModel(true, '${response.body}', response.body);
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        responseModel = ResponseModel(false, response.statusText!, response.body['errors']);
        update();
      }
    } catch (e) {
      _isLoading = false;
      update();
      responseModel = ResponseModel(false, "CATCH");
      log('++++++++ ${e.toString()} ++++++++', name: "ERROR AT submitDa()");
    }

    return responseModel;
  }

  syncData() async {
    if (await connectivity()) {
      SharedPreferences sharedPreferences = Get.find();
      List<dynamic> savedData = jsonDecode(sharedPreferences.getString('saved_data') ?? '[]');
      List remaining = [];
      if (savedData.isNotEmpty) {
        log(savedData.toString(), name: "Data available");
        for (int i = savedData.length - 1; i >= 0; i--) {
          var element = savedData[i];
          log("$element", name: "Data element");

          // if (false)
          submitDa(element).then((value) {
            if (value.isSuccess) {
              log("${value.isSuccess}");
              savedData.removeAt(savedData.indexOf(element));
            } else {
              remaining.add(element);
            }
          });
        }

        Fluttertoast.showToast(msg: "Synced Successfully");
        sharedPreferences.setString('saved_data', jsonEncode(remaining));
      } else {
        Fluttertoast.showToast(msg: "Synced Successfully");
      }
    } else {
      Fluttertoast.showToast(msg: "Please connect to internet");
    }
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  void setUserToken(String id) {
    authRepo.saveUserToken(id);
  }
}
