import 'dart:async';

import 'package:iclinix/data/api/api_client.dart';
import 'package:iclinix/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileRepo {
  final ApiClient apiClient;
  ProfileRepo({required this.apiClient,});


  Future<Response> updateProfileRepo(
      String? firstname,
      String? lastname,
      String? dob,
      String? diabetesProblem,
      String? bpProblem,
      String? eyeProblem,
      String? gender
      ) async {
    return await apiClient.postData(AppConstants.updateProfileUrl, {
      "fname" :firstname,
      "lname" :lastname,
      "dob": dob,
      "diabetes_problem" :diabetesProblem,
      "bp_problem" :bpProblem,
      "eye_problem" :eyeProblem,
      "gender" :gender,
    });
  }

  // Future<Response> getUserData() async {
  //   return await apiClient.getData(AppConstants.myProfileUrl,method: 'GET');
  // }





}
