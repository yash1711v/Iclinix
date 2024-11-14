import 'dart:async';

import 'package:iclinix/data/api/api_client.dart';
import 'package:iclinix/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ClinicRepo {
  final ApiClient apiClient;
  ClinicRepo({required this.apiClient,});

  Future<Response> getClinicList() {
    return apiClient.getData(AppConstants.clinicListUrl,method: 'GET');
  }

  Future<Response> getServicesList() {
    return apiClient.getData(AppConstants.serviceListUrl,method: 'GET');
  }

  Future<Response> getSearchList(String? iclinix) {
    return apiClient.getData('${AppConstants.searchListUrl}?query=$iclinix',method: 'GET',);
  }
  Future<Response> getServiceDetails(String? id) async {
    return await apiClient.getData('${AppConstants.serviceDetails}$id',method: 'GET');
  }


}




